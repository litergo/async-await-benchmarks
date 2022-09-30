public protocol NetworkDataTask:
    AnyObject,
    CustomDebugStringConvertible
{
    var anyEraser: AnyWeakNetworkDataTask? { get set }
    var cancellationHandler: (() -> ())? { get set }
    
    func cancel()
}

public final class AnyWeakNetworkDataTask {
    
    public weak var value: NetworkDataTask?
    
    public init(value: NetworkDataTask) {
        self.value = value
        value.anyEraser = self
    }
}
