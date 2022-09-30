import Foundation

enum SendAbuseResult {
    case success(title: String, description: String)
    case incorrectData(IncorrectData)
    case failure(GeneralError?)
}

protocol SendAbuseInteractor: AnyObject {
    var abuseData: AbuseData { get }
    
    // GCD
    func sendAbuse(verifyOnly: Bool, completion: @escaping (SendAbuseResult) -> ())
    // async/await
    func sendAbuse(verifyOnly: Bool) async -> SendAbuseResult
}

final class SendAbuseInteractorImpl: SendAbuseInteractor {
    
    // MARK: - Properties -
    private let abuseService: AbuseService
    let source: String?
    
    private(set) var abuseData: AbuseData
    
    // MARK: - Init -
    init(
        itemId: String,
        abuseId: String,
        source: String?,
        abuseService: AbuseService
    ) {
        self.abuseService = abuseService
        self.abuseData = AbuseData(itemId: itemId, abuseId: abuseId)
        self.source = source
    }
    
    // MARK: - AbuseInteractor -
    func sendAbuse(verifyOnly: Bool, completion: @escaping (SendAbuseResult) -> ()) {
        abuseService.sendAbuse(data: abuseData, verifyOnly: verifyOnly, source: source) { result in
            result.onData { data in
                switch data {
                case let .success(title, description):
                    completion(.success(title: title, description: description))
                case .incorrectData(let incorrectData):
                    completion(.incorrectData(incorrectData))
                }
            }
            result.onError { error in
                completion(.failure(error))
            }
        }
    }
    
    func sendAbuse(verifyOnly: Bool) async -> SendAbuseResult {
        async let sendAbuseResult = abuseService.sendAbuse(data: abuseData, verifyOnly: verifyOnly, source: source)
        switch await sendAbuseResult {
        case .data(let data):
            switch data {
            case .success(title: let title, description: let description):
                return .success(title: title, description: description)
            case .incorrectData(let incorrectData):
                return .incorrectData(incorrectData)
            }
        case .error(let error):
            return .failure(error)
        }
    }
}
