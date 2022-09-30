import Foundation

public enum NetworkClientError {
    case cantSignRequest(requestType: String)
    case noHttpResponse
    case parsingFailure(data: Data, message: String)
    case unboxMigrationValidationFailure(data: Data, message: String)
    case attemptToSendAuthorizedRequestWithNoSession(requestType: String)
    case cantBuildUrlFromRequest(requestType: String, urlString: String)
    case cantBuildUploadDataForRequest(requestType: String)
}

public final class NetworkRequestError<ApiErrorType> {
    public let errorId: String?
    public let type: NetworkRequestErrorType<ApiErrorType>
    
    public init(
        errorId: String?,
        type: NetworkRequestErrorType<ApiErrorType>)
    {
        self.errorId = errorId
        self.type = type
    }
}

public enum NetworkRequestErrorType<ApiErrorType> {
    case networkError(Error) // Got error from low level services
    case networkClientError(NetworkClientError) // Emited error within AvitoNetworking
    // TODO: Remove this when api completely refuses http codes
    case httpUnauthenticated  // special case for 401 http code processing in legacy api schema
    case apiError(ApiErrorType) // Got error from API
    case forbidden(message: String, link: URL?) // Got error from firewall, it might contain deeplink
    
    public var isUnauthenticated: Bool {
        if case .httpUnauthenticated = self {
            return true
        } else if
            case .apiError(let anyError) = self,
            let apiError = anyError as? ApiError,
            case .unauthenticated = apiError {
            return true
        } else {
            return false
        }
    }
    
    var firewallLink: URL? {
        guard case .forbidden(_, let link) = self else {
            return nil
        }
        return link
    }
    
    public var isForbidden: Bool {
        switch self {
        case .forbidden:
            return true
        case .apiError(let apiError):
            
            if let apiError = apiError as? OldFormatApiError {
                return apiError.code == 403 /* 403 Forbidden */
            }
            
            if let apiError = apiError as? ApiError {
                if case .forbidden = apiError {
                    return true
                }
            }
            return false
            
        default:
            return false
        }
    }
}

public typealias ApiResult<T> = DataResult<T, NetworkRequestError<OldFormatApiError>>

public final class OldFormatApiError: CustomStringConvertible, Decodable {
    public let code: Int
    public let message: String?
    public let messages: [String: String]
    
    public init(
        code: Int,
        message: String?,
        messages: [String: String])
    {
        self.code = code
        self.message = message
        self.messages = messages
    }
    
    // MARK: - CustomStringConvertible
    public var description: String {
        return """
        OldFormatApiError.
          code: \(code)
          message: \(message as Any)
          messages: \(messages)
        """
    }
}

public enum ApiError: Decodable {
    
    case unauthenticated(String)
    case unauthorized(String)
    case badRequest(String)
    case internalError(String)
    case notFound(String)
    case forbidden(message: String, link: URL?)
}


extension NetworkRequestError: GeneralErrorConvertible {
    public func toGeneralError() -> GeneralError {
        toGeneralError(errorId: errorId)
    }
    
    public func toGeneralError(errorId: String?) -> GeneralError {
        GeneralError(errorId: nil, implementation: .noInternetConnection)
    }
}
