import Foundation

class ThreadSafeCounter {
    private var count = 0
    private let queue = DispatchQueue(label: "serial.queue.avm")
    
    func increment() {
        queue.async {
            self.count += 1
        }
    }
    
    func read() -> Int {
        queue.sync {
            return self.count
        }
    }
}
