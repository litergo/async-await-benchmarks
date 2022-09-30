final class AbuseData {
    
    // MARK: - Properties -
    let itemId: String
    var abuseId: String?
    var name: String?
    var email: String?
    var comment: String?
    var emojiType: EmojiType?
    
    // MARK: - Calculated Properties -
    var isNameRequired: Bool {
        return false
    }
    
    var isEmailRequired: Bool {
        return false
    }
    
    var isCommentRequired: Bool {
        return false
    }
    
    // MARK: - Init
    init(itemId: String, abuseId: String) {
        
        self.itemId = itemId
        self.abuseId = abuseId
    }
}
