import Foundation

final class AbuseReportRequestApiMethod: ApiMethod {
    
    typealias Result = AbuseReportResponse
    
    let version = 1
    let httpMethod = HttpMethod.post
    let isAuthorizationRequired = false
    let shouldSendXGeo = true

    func path() -> String {
        return "abuse/report"
    }
    
    var pathDefinition: String {
        return path()
    }
    
    init() {
    }
}

final class AbuseReportRequest: NetworkRequest {
    
    let method = AbuseReportRequestApiMethod()
    
    private let abuseCategoryId: String
    private let itemId: String
    private let emotion: EmojiType
    private let comment: String?
    private let verifyOnly: Bool
    private let source: String?
    
    init(
        abuseCategoryId: String,
        itemId: String,
        emotion: EmojiType,
        comment: String?,
        verifyOnly: Bool,
        source: String?)
    {
        self.abuseCategoryId = abuseCategoryId
        self.itemId = itemId
        self.emotion = emotion
        self.comment = comment
        self.verifyOnly = verifyOnly
        self.source = source
    }
    
    var path: String {
        return method.path()
    }
    
    var params: [String: Any] {
        
        var result = [String: Any]()
        result["abuseCategoryId"] = abuseCategoryId
        result["itemId"] = itemId
        result["comment"] = comment
        result["emotion"] = emotion.rawValue
        result["verifyOnly"] = verifyOnly
        result["src"] = source
        return result
    }
}

enum EmojiType: Int {
    case pouting = 1
    case frowning
    case confused
    case neutral
    case smiling
}
