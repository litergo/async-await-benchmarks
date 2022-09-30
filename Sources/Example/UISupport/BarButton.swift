import UIKit

public class BarButton: NSObject {
    public typealias TapHandler = () -> ()
    
    @objc public let barButtonItem: UIBarButtonItem
    
    @objc public var title: String? {
        get { return barButtonItem.title }
        set { barButtonItem.title = newValue }
    }
    
    @objc public var onTap: TapHandler?
    
    @objc public var enabled: Bool {
        get { return barButtonItem.isEnabled }
        set { barButtonItem.isEnabled = newValue }
    }
    
    public var animationBlock: (() -> ())?
    
    init(title: String) {
        self.barButtonItem = UIBarButtonItem(
            title: title,
            style: .plain,
            target: nil,
            action: #selector(onButtonTap(_:))
        )
        
        super.init()
        
        barButtonItem.target = self
    }
    
    @objc func onButtonTap(_ sender: UIBarButtonItem) {
        onTap?()
    }
}
