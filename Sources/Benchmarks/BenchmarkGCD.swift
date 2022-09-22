import Benchmark
import Foundation

struct BenchmarkGCD {
    static func benchmarkThreadExplosion(
        numberOfTasks: Int,
        difficulty: Int
    ) {
        benchmark("GCD thread explosion benchmark N = \(numberOfTasks), D = \(difficulty)") {
            let gcdTests = GCDTests()
            let group = DispatchGroup()
            group.enter()

            gcdTests.measureGCD(
                numberOfTasks: numberOfTasks,
                difficulty: difficulty) {
                    group.leave()
                }
            
            group.wait()
        }
    }
    
    static func benchmarkCriticalSection(numberOfTasks: Int) {
        benchmark("GCD critical section benchmark N = \(numberOfTasks)") {
            let gcdTests = GCDTests()
            let group = DispatchGroup()
            group.enter()
            
            gcdTests.measureCriticalSection(numberOfTasks: numberOfTasks) {
                group.leave()
            }
            
            group.wait()
        }
    }
}
