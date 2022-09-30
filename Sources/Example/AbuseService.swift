import Foundation

protocol AbuseService: AnyObject {
    // GCD
    func sendAbuse(data: AbuseData, verifyOnly: Bool, source: String?, completion: @escaping (GeneralResult<AbuseReportResponse>) -> ())
    // async/await
    func sendAbuse(data: AbuseData, verifyOnly: Bool, source: String?) async -> GeneralResult<AbuseReportResponse>
}

final class AbuseServiceImpl: AbuseService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func sendAbuse(
        data: AbuseData,
        verifyOnly: Bool,
        source: String?,
        completion: @escaping (GeneralResult<AbuseReportResponse>) -> ())
    {
        let request = AbuseReportRequest(
            abuseCategoryId: data.abuseId ?? "",
            itemId: data.itemId,
            emotion: data.emojiType ?? .confused,
            comment: data.comment,
            verifyOnly: verifyOnly,
            source: source
        )
        
        networkClient.send(request: request) { result in
            completion(result.toGeneralResult())
        }
    }
    
    func sendAbuse(
        data: AbuseData,
        verifyOnly: Bool,
        source: String?
    ) async -> GeneralResult<AbuseReportResponse> {
        let request = AbuseReportRequest(
            abuseCategoryId: data.abuseId ?? "",
            itemId: data.itemId,
            emotion: data.emojiType ?? .confused,
            comment: data.comment,
            verifyOnly: verifyOnly,
            source: source
        )
        
        return await networkClient.send(request: request).toGeneralResult()
    }
}
