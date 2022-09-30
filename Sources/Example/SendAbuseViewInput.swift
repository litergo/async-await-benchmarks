import Foundation

protocol SendAbuseViewInput: AnyObject {
    var onBackTap: (() -> ())? { get set }
    var onInputEnd: (() -> ())? { get set }

    func setLoading(_: Bool)
    func setTitle(_ title: String)
    func showSuccess(title: String, description: String)
    func showError(_ error: GeneralError?)
}
