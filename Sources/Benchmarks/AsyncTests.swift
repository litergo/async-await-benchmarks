import Foundation

public class AsyncTests {
    public init() { }

    public func measureAsync(numberOfTasks: Int, difficulty: Int) async {
        await withTaskGroup(of: Void.self) { group in
            for _ in 1...numberOfTasks {
                group.addTask {
                    let _ = await self.asyncTask(difficulty)
                }
            }
            await group.waitForAll()
        }
    }
    
    public func measureCriticalSection(numberOfTasks: Int) async {
        let counterActor = Counter()
        
        await withTaskGroup(of: Void.self, body: { group in
            for _ in 1...numberOfTasks {
                group.addTask {
                    await counterActor.increment()
                }
            }
            await group.waitForAll()
        })
    }
    
    func asyncTask(_ difficulty: Int) async -> Void {
        HardTask.task(difficulty)
    }
}
