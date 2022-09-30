import Foundation

public class GCDTests {
    public init() { }
    
    public func measureGCD(
        numberOfTasks: Int,
        difficulty: Int,
        completion: (() -> Void)? = nil
    ) {
        let counter = ThreadSafeCounter()
        
        for _ in 1...numberOfTasks {
            DispatchQueue.global().async {
                self.task(difficulty)
                counter.increment()
                if counter.read() == numberOfTasks {
                    completion?()
                }
            }
        }
    }
    
    public func measureCriticalSection(
        numberOfTasks: Int,
        completion: (() -> Void)? = nil
    ) {
        let counter = ThreadSafeCounter()
        
        for _ in 1...numberOfTasks {
            DispatchQueue.global().async {
                counter.increment()
                if counter.read() == numberOfTasks {
                    completion?()
                }
            }

        }
    }
    
    func task(_ difficulty: Int) -> Void {
        HardTask.task(difficulty)
    }
}
