public protocol ApiMethod {
    associatedtype Result
    associatedtype ErrorResponse
    
    var version: Int { get }
    // Override extension and return nil to prevent version from being added to the url. See `RequestBuilder`
    var versionPathComponent: Int? { get }
    
    // Do not override prefix for standard api requests
    var pathPrefix: String { get }
    
    var httpMethod: HttpMethod { get }
    var shouldSendXGeo: Bool { get }
    var isAuthorizationRequired: Bool { get }
    var serializationProtocol: SerializationProtocol { get }
    var executeUnauthenticatedError: Bool { get }
    
    var errorConverter: AnyNetworkResponseConverter<ErrorResponse> { get }
    
    /// Temporary property. Validator for migration from Unbox to Decodable
    var unboxMigrationValidator: UnboxMigrationValidator<Result> { get }
    
    // AI-5646: Used to generate supported api method reports
    // Use braces for query parameter placeholders
    //
    // public var pathDefinition: String {
    //     return path(itemId: "{itemId}")  // <---- placeholder is in braces
    // }
    //
    // func path(itemId: String) -> String {
    //     return "items/\(itemId)/delivery/points/filter"
    // }
    var pathDefinition: String { get }
    
    // Use for debugging, if you need route one call to another host
    #if DEBUG || TEST
    var host: String? { get }
    #endif
}

public extension ApiMethod {
    var versionPathComponent: Int? {
        return version
    }
}

extension ApiMethod {
    
    // Do not override prefix for standard api requests
    public var pathPrefix: String {
        return "api"
    }
    
    public var shouldSendXGeo: Bool {
        return false
    }
    
    public var serializationProtocol: SerializationProtocol {
        return .json
    }
    
    public var executeUnauthenticatedError: Bool {
        return true
    }
    
    public var errorConverter: AnyNetworkResponseConverter<ApiError> {
        return AnyNetworkResponseConverter(ApiErrorConverter())
    }
    
    #if DEBUG || TEST
    public var host: String? {
        return nil
    }
    #endif
}

/// Temporary extension. Always succeeding validator for migration from Unbox to Decodable, called for all not-Decodable & Equatable types.
public extension ApiMethod {
    var unboxMigrationValidator: UnboxMigrationValidator<Result> { .alwaysSucceeding }
}

/// Temporary extension. Validator for migration from Unbox to Decodable, called for all Decodable and not-Equatable types.
public extension ApiMethod where Result: Decodable {
    var unboxMigrationValidator: UnboxMigrationValidator<Result> { .validatingDecodable }
}

/// Temporary extension. Validator for migration from Unbox to Decodable, called for all Decodable & Equatable types.
public extension ApiMethod where Result: Decodable & Equatable {
    var unboxMigrationValidator: UnboxMigrationValidator<Result> { .validatingDecodableAndEquatable }
}
