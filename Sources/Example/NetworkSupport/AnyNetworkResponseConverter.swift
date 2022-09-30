import Foundation

/// Type erasure wrapper for any instance of NetworkResponseConverter
public final class AnyNetworkResponseConverter<ConversionResult>: NetworkResponseConverter {
    private let decodeResponseDataFunction: (_ statusCode: Int, _ data: Data) throws -> ConversionResult
    
    public init<C: NetworkResponseConverter>(_ converter: C) where C.ConversionResult == ConversionResult {
        decodeResponseDataFunction = converter.convertResponse
    }
    
    public func convertResponse(statusCode: Int, data: Data) throws -> ConversionResult {
        return try decodeResponseDataFunction(statusCode, data)
    }
}
