import Foundation

public extension Sequence {

    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }

    func prefix(while predicate: (Iterator.Element) -> Bool) -> [Iterator.Element] {
        var result: [Iterator.Element] = []

        for element in self {
            if !predicate(element) {
                return result
            }

            result.append(element)
        }

        return result
    }

}

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Index == Int {
    
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
    
    func randomElements(maxCount: Int) -> [Iterator.Element]  {
        return Array(shuffled().prefix(maxCount))
    }
    
}
