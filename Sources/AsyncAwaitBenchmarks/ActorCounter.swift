import Foundation

actor Counter {
    private var count: Int = 0
    func increment() { count += 1 }
    func read() -> Int { count }
}
