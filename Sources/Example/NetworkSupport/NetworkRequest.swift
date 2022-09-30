import Foundation

public protocol NetworkRequest {
    
    associatedtype Method: ApiMethod
    typealias Response = DataResult<Method.Result, NetworkRequestError<Method.ErrorResponse>>
    typealias ParsingResult = DataResult<Method.Result, NetworkRequestErrorType<Method.ErrorResponse>>
    
    var baseUrl: String? { get }
    var method: Method { get }
    var path: String { get }
    var headers: [HttpHeader] { get }
    var params: [String: Any] { get }
    var httpBody: Data? { get }
    var cachePolicy: NetworkRequestCachePolicy { get }
    var prefferedCompletionQueue: DispatchQueue? { get }
}

public enum SerializationProtocol {
    case protobuf, json
}

public enum NetworkRequestCachePolicy {
    case useProtocolCachePolicy
    case reloadIgnoringLocalCacheData
    case returnCacheDataElseLoad
    case returnCacheDataDontLoad

    var toNSURLRequestCachePolicy: NSURLRequest.CachePolicy {
        switch self {
        case .useProtocolCachePolicy:
            return .useProtocolCachePolicy
        case .reloadIgnoringLocalCacheData:
            return .reloadIgnoringLocalCacheData
        case .returnCacheDataElseLoad:
            return .returnCacheDataElseLoad
        case .returnCacheDataDontLoad:
            return .returnCacheDataDontLoad
        }
    }
}

// MARK: - Default declarations
public extension NetworkRequest {
    var baseUrl: String? { nil }
}

extension NetworkRequest {
    public var cachePolicy: NetworkRequestCachePolicy {
        return .useProtocolCachePolicy
    }
    public var headers: [HttpHeader] { return [] }
    
    public var httpBody: Data? {
        return nil
    }
    
    public var prefferedCompletionQueue: DispatchQueue? {
        get { return DispatchQueue.main }
    }
}

extension NetworkRequest {
    func normalizedQueryPath() -> String {
        return path.normalizedQueryPath()
    }
}

extension String {
    func normalizedQueryPath() -> String {
        // remove leading and trailing `/` characters
        let components = self.components(separatedBy: "/")
        let nonEmptyComponents = components.filter { !$0.isEmpty }
        
        // return leading `/` character
        return "/" + nonEmptyComponents.joined(separator: "/")
    }
}
