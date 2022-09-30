import Foundation

/// Temporary object. Validator for migration from Unbox to Decodable,
/// find more at https://cf.avito.ru/pages/viewpage.action?pageId=232426857
public final class UnboxMigrationValidator<ModelToValidateType> {

    enum ValidationError<ModelToValidateType>: Error {
        case decodedNotEqualToUnboxed(String)
        case failedToDecode(Error)
    }

    let validate: (Data, ModelToValidateType) -> ValidationError<ModelToValidateType>?
    
    init(validate: @escaping (Data, ModelToValidateType) -> ValidationError<ModelToValidateType>?) {
        self.validate = validate
    }
}

extension UnboxMigrationValidator {
    
    static var alwaysSucceeding: UnboxMigrationValidator {
        .init { _, _ in
            nil
        }
    }
}

/// Validator for migration from `Unbox` to `Decodable`, called for all `Decodable` and non-`Equatable` types.
extension UnboxMigrationValidator where ModelToValidateType: Decodable {
    
    static var validatingDecodable: UnboxMigrationValidator {
        .init { data, modelToValidate in
            return nil
        }
    }
}

/// Validator for migration from `Unbox` to `Decodable`, called for all `Decodable & Equatable` types.
extension UnboxMigrationValidator where ModelToValidateType: Decodable & Equatable {
    
    static var validatingDecodableAndEquatable: UnboxMigrationValidator {
        .init { data, modelToValidate in
            return nil
        }
    }
}

/// Extension making `ValidationError` conform to `CustomStringConvertible`
extension UnboxMigrationValidator.ValidationError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decodedNotEqualToUnboxed:
            return "[UnboxMigrationValidator] \(ModelToValidateType.self) failed: Decoded is not equal to unboxed"
        case .failedToDecode(let decodingError):
            return "[UnboxMigrationValidator] \(ModelToValidateType.self) failed: \(decodingError)"
        }
    }
}
