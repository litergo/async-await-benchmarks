import Foundation
import UIKit

final class SendAbuseViewController: UIViewController, SendAbuseViewInput {

    private let abuseView = UIView()
    private let sendButton = BarButton(title: "send")
    private let backButton = BarButton(title: "back")
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        preferredContentSize = CGSize.zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = abuseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = backButton.barButtonItem
        navigationItem.rightBarButtonItem = sendButton.barButtonItem
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view?.endEditing(true)
    }
    
    var onBackTap: (() -> ())? {
        get { return backButton.onTap }
        set { backButton.onTap = newValue }
    }
    
    var onInputEnd: (() -> ())? {
        get { return sendButton.onTap }
        set { sendButton.onTap = newValue }
    }
    
    func setLoading(_ loading: Bool) {
        // some UI work
        abuseView.isHidden = loading
    }
    
    func setSendEnabled(_ sendEnabled: Bool) {
        // some UI work
        abuseView.isHidden = sendEnabled
    }
    
    func showError(_ error: GeneralError?) {
        // some UI work
        abuseView.isHidden = true
    }
    
    func showSuccess(title: String, description: String) {
        // some UI work
        abuseView.isHidden = false
    }

    
    @nonobjc func setTitle(_ title: String) {
        self.title = title
    }
}
