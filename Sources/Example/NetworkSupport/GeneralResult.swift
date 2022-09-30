import Foundation

public typealias GeneralResult<T> = DataResult<T, GeneralError>

public final class GeneralError: Error, Equatable {
    public let errorId: String?
    
    // NOTE: This property should be private! (it was until some moment)
    // Code shouldn't rely on implementation.
    // Use ErrorMessageDataBuilder to get info about error.
    // (they are quite same and it is bad that there are two of them)
    public let implementation: GeneralErrorImplementation
    
    public enum GeneralErrorImplementation: Equatable {
        case unclassified // we don't care about a text
        case noInternetConnection // no connection
        case serverIsUnreachable // network problems and such things
        case silent(message: String?, link: URL?) // no need to disturb the user
        case userIsNotAuthenticated(message: String?)
        case businessLogicError(message: String)
    }

    public init(errorId: String? = nil, implementation: GeneralErrorImplementation) {
        self.errorId = errorId
        self.implementation = implementation
    }
    
    public var isNetworkProblem: Bool {
        return self.implementation == .noInternetConnection || self.implementation == .serverIsUnreachable
    }
}

// MARK: - Equatable

public func == (lhs: GeneralError, rhs: GeneralError) -> Bool {
    return lhs.implementation == rhs.implementation
}

public func ==(left: GeneralError.GeneralErrorImplementation, right: GeneralError.GeneralErrorImplementation) -> Bool {
    switch (left, right) {
    case (.unclassified, .unclassified),
         (.serverIsUnreachable, .serverIsUnreachable),
         (.userIsNotAuthenticated, .userIsNotAuthenticated),
        (.noInternetConnection, .noInternetConnection):
        return true
    case let (.businessLogicError(a), .businessLogicError(b)) where a == b:
        return true
    case let (.silent(firstMessage, firstLink), .silent(secondMessage, secondLink)):
        return firstMessage == secondMessage && firstLink == secondLink

    default:
        return false
    }
}
