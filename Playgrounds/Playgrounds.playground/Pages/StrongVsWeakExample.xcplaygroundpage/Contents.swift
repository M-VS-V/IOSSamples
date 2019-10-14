//: [Previous](@previous)

import Foundation

class TestObject {
    init() {
        print("TestObject created")
    }
    deinit {
        print("TestObject killed")
    }
}

class WeakExample {
    weak var testObject = TestObject()
}

class StrongExample {
    var testObject = TestObject()
    
    deinit {
        print("StrongExample deinit")
    }
}

let a = WeakExample()
