import Foundation

final class ApiErrorConverter: NetworkResponseConverter {
    typealias ConversionResult = ApiError
    
    func convertResponse(statusCode: Int, data: Data) throws -> ConversionResult {
        return .internalError("Mock")
    }
}
