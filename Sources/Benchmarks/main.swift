import Benchmark
import Foundation

BenchmarkAsyncAwait.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 10_000)
BenchmarkGCD.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 10_000)

BenchmarkAsyncAwait.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 100_000)
BenchmarkGCD.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 100_000)

BenchmarkAsyncAwait.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 500_000)
BenchmarkGCD.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 500_000)

BenchmarkAsyncAwait.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 1_000_000)
BenchmarkGCD.benchmarkThreadExplosion(numberOfTasks: 100_000, difficulty: 1_000_000)

BenchmarkAsyncAwait.benchmarkThreadExplosion(numberOfTasks: 1_000_000, difficulty: 10_000)
BenchmarkGCD.benchmarkThreadExplosion(numberOfTasks: 1_000_000, difficulty: 10_000)

BenchmarkAsyncAwait.benchmarkActor(numberOfTasks: 10_000)
BenchmarkGCD.benchmarkCriticalSection(numberOfTasks: 10_000)

BenchmarkAsyncAwait.benchmarkActor(numberOfTasks: 100_000)
BenchmarkGCD.benchmarkCriticalSection(numberOfTasks: 100_000)

BenchmarkAsyncAwait.benchmarkActor(numberOfTasks: 1_000_000)
BenchmarkGCD.benchmarkCriticalSection(numberOfTasks: 1_000_000)

Benchmark.main()
