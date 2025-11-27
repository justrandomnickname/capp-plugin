import Foundation

@objc public class webviewgenie: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
