//: [Previous](@previous)

import Foundation

//Example1
//Запущен будет метод класса – таковы уж особенности диспетчеризации методов в Swift

print("--Example1--\n")
protocol Person {
     func work()
}

extension Person {
    func work() {
        print("Person")
    }
}
class Employee: Person {
    func work() {
        print("Employee")
    }
}

Employee().work()
(Employee() as? Person)?.work()

//Example2

print("\n--Example2--\n")
protocol Person1 {
}

extension Person1 {
    func work() {
        print("Person1")
    }
}
class Employee1: Person1 {
    func work() {
        print("Employee1")
    }
}

Employee1().work()
(Employee1() as? Person1)?.work()

print("excample3")

protocol Pet {
    func waitingForItsOwner()
}
extension Pet {
    func yawn() {
        print ("Pet yawns")
    }
}

protocol Sleeper {
    func sleepOnAChair()
}
extension Sleeper {
    func yawn() {
        print ("Sleeper yawns")
    }
}
class Kitty: Pet, Sleeper {
    func eat() {
        print("yammy")
    }
    func waitingForItsOwner() {
        print("looking at the door")
    }
    func sleepOnAChair() {
        print("dreams")
    }
}

let kitty = Kitty()
(kitty as Sleeper).yawn()
(kitty as Pet).yawn()
//kitty.yawn() //error
 

//example4

protocol Pet1 {
    func waitingForItsOwner()
}
extension Pet1 {
    func yawn() {
        print ("Pet yawns")
    }
}

protocol Cat1: Pet1 {
    func walk()
}
extension Cat1 {
    func yawn() {
        print ("Cat yawns")
    }
}
class Kitty1: Cat1 {
    func walk() {
        
    }
    func eat() {
        print("yammy")
    }
    func waitingForItsOwner() {
        print("looking at the door")
    }
    func sleepOnAChair() {
        print("dreams")
    }
}
let kitty1 = Kitty1()
kitty1.yawn()

//Также стоит заметить, что можно наследовать протокол только при одном типе связей.
protocol ObjectConfigurator { }
protocol Property { }

class FirstProperty: Property { }
class SecondProperty: Property { }

class Configurator<T> where T: Property {
    var properties: T
    init(properties: T) {
        self.properties = properties
    }
}
extension Configurator: ObjectConfigurator where T == FirstProperty { }
// тут будет ошибка:
 // Redundant conformance of 'Configurator<T>' to protocol 'ObjectConfigurator'
extension Configurator: ObjectConfigurator where T == SecondProperty { }

