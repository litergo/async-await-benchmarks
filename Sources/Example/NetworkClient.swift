import Foundation

public typealias NetworkClientCompletion<R: NetworkRequest> = NetworkClientResult<R>.Completion
public typealias NetworkClientResult<R: NetworkRequest> = DataResult<R.Method.Result, NetworkRequestError<R.Method.ErrorResponse>>

public protocol NetworkClient: AnyObject {
    @discardableResult
    // GCD
    func send<R: NetworkRequest>(request: R, completion: @escaping NetworkClientCompletion<R>) -> NetworkDataTask?
    // async/await
    func send<R: NetworkRequest>(request: R) async -> DataResult<R.Method.Result, NetworkRequestError<R.Method.ErrorResponse>>
}
