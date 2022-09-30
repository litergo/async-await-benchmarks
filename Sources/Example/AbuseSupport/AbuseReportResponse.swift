import Foundation

enum AbuseReportResponse: Decodable {
    
    case success(title: String, description: String)
    case incorrectData(IncorrectData)
    
    init(title: String, description: String) {
        self = .success(title: title, description: description)
    }
}


// Model for most frequent case of incorrect-data response structure
public final class IncorrectData: Equatable, Decodable {
    public let messages: [String: String]
    
    public init(messages: [String: String]) {
        self.messages = messages
    }
    
    public static func ==(lhs: IncorrectData, rhs: IncorrectData) -> Bool {
        return lhs.messages == rhs.messages
    }
    
    // MixboxGenerators:begin
    #if TEST
    public init(fields: Fields<IncorrectData>) throws {
        messages = try fields.messages.get()
    }
    #endif
    // MixboxGenerators:end
}
