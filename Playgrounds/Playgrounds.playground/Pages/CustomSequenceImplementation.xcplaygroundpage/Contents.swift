import UIKit

//Custom sequence example

protocol Model {
    var value: String { get }
}

protocol ModelStorage {
    func model(at index: Int) -> Model?
}

struct ModelImpl: Model {
    let value: String
}

struct StringsStorage: ModelStorage  {
    let values: [ModelImpl]
    
    init(strings: [String]) {
        values = strings.map { x in ModelImpl(value: x) }
    }
    
    func model(at index: Int) -> Model? {
        return values[safe: index]
    }
    
}
struct ModelSequence: Sequence {
    let storage: ModelStorage
    func makeIterator() -> ModelIterator {
        return ModelIterator(storage: storage)
    }
}

struct ModelIterator: IteratorProtocol {
    let storage: ModelStorage
    var index = 0
    mutating func next() -> Model? {
        let model = storage.model(at: index)
        guard model?.value ?? "" <= "x" else { return nil }
        index += 1
        return model
    }
}

let storage = ModelSequence(storage: StringsStorage(strings: ["a","b","c","f","x","y","z"]))
for x in storage {
    print(x)
}


//AnySequence example

let oddIntSequenceLessThen20 = AnySequence { () -> AnyIterator<Int> in
    var i = 0
    return AnyIterator {
        i += 2
        if i > 20 { return nil }
        return i
    }
}

for x in oddIntSequenceLessThen20 {
    print(x)
}


