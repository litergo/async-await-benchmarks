import Foundation

/// Converts raw response data to native data types
public protocol NetworkResponseConverter: AnyObject {
    
    /// Native data type to be converted to
    associatedtype ConversionResult
    
    /// Conversion method
    /// - Parameters:
    ///   - statusCode: Status code of response, it's legacy and expected to be removed out of here later
    ///   - data: Raw response data
    /// - Returns: Native data type if conversion  succeeded
    func convertResponse(statusCode: Int, data: Data) throws -> ConversionResult
}

public final class DefaultNetworkResponseConverterError: Error {
    public init() {}
}
