import UIKit

//შექმენით ციკლური რეფერენცები და გაწყვიტეთ
//აუცილებელია ქლოჟერების გამოყენება
//აუცილებელია value და რეფერენს ტიების გამოყენება (კლასები, სტრუქტურები, ენამები და პროტოკოლები)
//აუცილებელია გამოიყენოთ strong, weak & unowned რეფერენსები ერთხელ მაინც
//დაიჭირეთ self ქლოჟერებში
//გატესტეთ მიღებული შედეგები ინსტანსების შექმნით და დაპრინტვით

protocol Employee{
    var personalNumber: String { get set }
    var age: Int {get set}
    func printInfo()
}
enum gender{
    case male
    case female
}

struct Address{
    var city: String
    var country: String
}

class Person: Employee{
    var personalNumber: String
    var age: Int
    var name: String
    var gender: gender?
    unowned var customer: Customer
    
    init(personalNumber: String,
         age: Int,
         name: String,
         customer: Customer){
        self.personalNumber = personalNumber
        self.age = age
        self.name = name
        self.customer = customer
    }
    func printInfo() {
     print("personalNumber: \(personalNumber), age: \(age), name: \(name)")
    }
    deinit {
      print("person is being deinitialized")
    }
    
    var sayHello: (() -> Void)?
}

class Customer: Employee{
    var personalNumber: String
    var age: Int
    var surname: String
    var address: Address
    weak var person: Person?
    
    init(personalNumber: String,
         age: Int,
         surname: String,
         address: Address){
        self.personalNumber = personalNumber
        self.age = age
        self.surname = surname
        self.address = address
    }
    func printInfo() {
     print("personalNumber: \(personalNumber), age: \(age), surname: \(surname)")
    }
    deinit {
      print("customer is being deinitialized")
    }
   
    var sayHello: ((String) -> Void)?
    
}

var address1: Address = Address(city: "Tbilisi", country: "Georgia")
var address2: Address = Address(city: "Batumi", country: "Georgia")

var customer1: Customer = Customer(personalNumber: "12002938723", age: 24, surname: "Bagrationi", address: address1)
var customer2: Customer = Customer(personalNumber: "31002933827", age: 25, surname: "Jayeli", address: address2)

var person1: Person = Person(personalNumber: "12993827371", age: 22, name: "Erekle", customer: customer1)

customer2.person = person1

customer1.sayHello = {
    name in
    print("Hi \(name)")
}

customer1.sayHello!(person1.name)

person1.sayHello = {
    print("Good morning")
}
person1.sayHello!()

customer2.person = nil
customer1.sayHello = nil
person1.sayHello = nil



