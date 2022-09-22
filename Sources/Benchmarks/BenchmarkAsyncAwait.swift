import Benchmark
import Foundation

struct BenchmarkAsyncAwait {
    static func benchmarkThreadExplosion(
        numberOfTasks: Int,
        difficulty: Int
    ) {
        benchmark("async/await thread explosion benchmark N = \(numberOfTasks), D = \(difficulty)") {
            let asyncTests = AsyncTests()

            let group = DispatchGroup()
            group.enter()
            
            Task {
                await asyncTests.measureAsync(
                    numberOfTasks: numberOfTasks,
                    difficulty: difficulty
                )
                group.leave()
            }
            
            group.wait()
        }
    }
    
    static func benchmarkActor(numberOfTasks: Int) {
        benchmark("async/await actor benchmark N = \(numberOfTasks)") {
            let asyncTests = AsyncTests()

            let group = DispatchGroup()
            group.enter()

            Task {
                await asyncTests.measureCriticalSection(numberOfTasks: numberOfTasks)
                group.leave()
            }

            group.wait()
        }
    }
}
