import Foundation

public protocol DataCreator: AnyObject {
    func createData(completion: @escaping (_ data: Data?, _ metadata: [String: Any]) -> ())
}
