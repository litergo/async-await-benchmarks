import Foundation

final class SendAbusePresenter {
    
    // MARK: - Private properties -
    private let interactor: SendAbuseInteractor
    
    // MARK: - Init -
    init(interactor: SendAbuseInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Weak properties -
    @MainActor
    weak var view: SendAbuseViewInput? {
        didSet {
            Task {
                await setUpView()
            }
        }
    }
    
    // MARK: - Private -
    private func setUpView() async {
        await view?.setTitle("Жалоба")
        await view?.onInputEnd = onInputEnd
    }
    
    private func onInputEnd() {
        Task {
            await sendAbuse()
        }
    }
    
    private func sendAbuse() async {
        
        await view?.setLoading(true)
        let result = await interactor.sendAbuse(verifyOnly: false)
        await view?.setLoading(false)
        
        switch result {
        case let .success(title, description):
            await showAbuseSuccess(title: title, description: description)
        case .incorrectData(let data):
            await processIncorrectData(data)
        case .failure(let error):
            await view?.showError(error)
        }
    }
    
    private func showAbuseSuccess(title: String, description: String) async {
        await view?.showSuccess(title: title, description: description)
    }
    
    private func processIncorrectData(_ data: IncorrectData) async {
        // do some work
        
    }
}
