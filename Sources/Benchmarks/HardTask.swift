import Foundation

class HardTask {
    static func task(_ difficulty: Int) {
        var evenCount = 0
        for i in 1...getRandomInt(difficulty) {
            if i % 2 == 0 {
                evenCount += 1
            }
        }
        precondition(evenCount >= (difficulty - 1000) / 2)
    }
    
    static func getRandomInt(_ difficulty: Int) -> Int {
        return Int.random(in: difficulty-1000...difficulty+1000)
    }
}
