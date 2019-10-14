//: [Previous](@previous)

import Foundation

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
let queue = DispatchQueue.global()
//
//var employees = ["Bill", "Bob", "Joe"]
//
//queue.async {
//    let count = employees.count
//    for index in 0 ..< count {
//        print("\(employees[index])")
//        Thread.sleep(forTimeInterval: 1)
//    }
//}
//
//queue.async {
//    Thread.sleep(forTimeInterval: 0.5)
//    print("remove")
//    employees.remove(at: 0)
//}

struct Person {
    var firstName: String
    var lastName: String
}

var person = Person(firstName: "Rob", lastName: "Ryan")

queue.async { [person] in
    Thread.sleep(forTimeInterval: 0.5)
    print("1: \(person)")
}

queue.async {
    person.firstName = "Rachel"
    Thread.sleep(forTimeInterval: 1)
    person.lastName = "Moore"
    print("2: \(person)")
}
