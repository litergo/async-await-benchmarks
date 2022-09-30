import Foundation

public final class HttpHeader {
    public enum DefaultField: String {
        case contentEncoding = "Content-Encoding"
        case contentType = "Content-Type"
        case userAgent = "User-Agent"
        case xSession = "X-Session"
        case xDeviceId = "X-DeviceId"
        case xApplicationKey = "X-ApplicationKey"
        case xGeo = "X-Geo"
        case xDate = "X-Date"
        case xSupportedFeatures = "X-Supported-Features"
        case fingerPrint = "f"
        case fingerPrintId = "ft"
        case securedTouch = "st"
        case xPaymentsPlan = "X-Payments-Plan"
        case xRequestId = "X-Request-Id"
        case xRoute = "X-Route"
        case xInfmVersion = "X-Infm-Version"
        case xTimezone = "X-Timezone"
        case attributedStringVersion = "at-v"
        
        var name: String {
            return rawValue
        }
    }
    
    public let name: String
    public let value: String
    
    // MARK: - Init
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    public init(field: DefaultField, value: String) {
        name = field.name
        self.value = value
    }
    
    init?(field: DefaultField, value: String?) {
        guard let fieldValue = value else {
            return nil
        }
        name = field.name
        self.value = fieldValue
    }
    
    #if TEST
    public init() {
        name = ""
        value = ""
    }
    #endif
}
