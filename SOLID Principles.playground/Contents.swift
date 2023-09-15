import UIKit

/* SOLID is an acronym that represents a set of five design principles for writing maintainable and scalable software. These principles were introduced by Robert C. Martin and have become fundamental concepts in object-oriented programming and software design. */

// S - Single Responsibility Principle
// O - Open/Closed Principle
// L - Liskov Substitution Principle
// I - Interface Segregation Principle
// D - Dependency Inversion Principle

// MARK: - SINGLE RESPONSIBILITY PRINCIPLE
/* The Single Responsibility Principle (SRP) states that a class should have only one reason to change, meaning it should have a single responsibility. */

/* Suppose you're building a class for a banking application that manages customer accounts. The class should handle two responsibilities:
Managing account information (e.g., balance, account number).
Performing financial transactions (e.g., deposits, withdrawals).
However, following SRP, you should split these responsibilities into separate classes. */

// Here's an example of a class violating SRP:
class BankAccount {
	var accountNumber: String
	var balance: Double
	
	init(accountNumber: String, initialBalance: Double) {
		self.accountNumber = accountNumber
		self.balance = initialBalance
	}
	
	func deposit(amount: Double) {
		// Deposit money into the account
		balance += amount
	}
	
	func withdraw(amount: Double) {
		// Withdraw money from the account
		balance -= amount
	}
	
	func getAccountInfo() {
		// Display account information
		print("Account Number: \(accountNumber)")
		print("Balance: \(balance)")
	}
}

// In this example, the BankAccount class has multiple responsibilities: managing account information and performing transactions. This violates SRP because changes to one aspect of the class (e.g., transaction logic) can impact another (e.g., account information).

// To adhere to SRP, you can split this class into two separate classes—one for managing account information and another for performing transactions:
class BankAccountInfo {
	var accountNumber: String
	var balance: Double
	
	init(accountNumber: String, initialBalance: Double) {
		self.accountNumber = accountNumber
		self.balance = initialBalance
	}
	
	func getAccountInfo() {
		// Display account information
		print("Account Number: \(accountNumber)")
		print("Balance: \(balance)")
	}
}

class BankAccountTransaction {
	var account: BankAccountInfo
	
	init(account: BankAccountInfo) {
		self.account = account
	}
	
	func deposit(amount: Double) {
		// Deposit money into the account
		account.balance += amount
	}
	
	func withdraw(amount: Double) {
		// Withdraw money from the account
		account.balance -= amount
	}
}

// In this revised example, BankAccountInfo is responsible for managing account information, and BankAccountTransaction handles financial transactions. This separation adheres to SRP, making each class focused on a single responsibility and easier to maintain and extend.

// MARK: - OPEN/CLOSED PRINCIPLE
/* The Open/Closed Principle (OCP) states that software entities (classes, modules, functions, etc.) should be open for extension but closed for modification. In other words, you should be able to extend the behavior of a class without changing its source code. */

/* Let's say you have a simple order processing system with different types of orders: standard orders and discounted orders. Initially, you have a class that calculates the total cost for standard orders: */

struct Product {
	var name: String
	var price: Double
}

class StandardOrder {
	let items: [Product]
	
	init(items: [Product]) {
		self.items = items
	}
	
	func calculateTotal() -> Double {
		return items.reduce(0) { $0 + $1.price }
	}
}

/* In this case, StandardOrder calculates the total cost of products in the order by summing their prices. However, you receive a new requirement to handle discounted orders without modifying the existing code.

To adhere to the Open/Closed Principle, you can create a new subclass, DiscountedOrder, that extends the behavior of the base class StandardOrder: */

class DiscountedOrder: StandardOrder {
	let discountPercentage: Double
	
	init(items: [Product], discountPercentage: Double) {
		self.discountPercentage = discountPercentage
		super.init(items: items)
	}
	
	override func calculateTotal() -> Double {
		let standardTotal = super.calculateTotal()
		let discount = standardTotal * (discountPercentage / 100.0)
		return standardTotal - discount
	}
}

/* Now, you have a new class, DiscountedOrder, that inherits from StandardOrder and overrides the calculateTotal() method to apply the discount. You've extended the behavior without modifying the existing StandardOrder class, adhering to the Open/Closed Principle.

You can use both StandardOrder and DiscountedOrder in your application without changing the original code for StandardOrder. This allows you to add more types of orders in the future by creating new subclasses, making your code more extensible and maintainable. */

// MARK: - LISKOV SUBSTITUTION PRINCIPLE
/* The Liskov Substitution Principle (LSP) states that objects of a derived class should be substitutable for objects of the base class without affecting the correctness of the program. In other words, if a class S is a subclass of class T, you should be able to use an object of class S wherever you use an object of class T, and the program should still work as expected. */

/* Let's consider a scenario where you have a base class called Bird, and you have a derived class called Penguin. According to the LSP, a Penguin should be substitutable for a Bird without causing issues. Both Bird and Penguin can fly, but a Penguin flies differently from most birds—it swims instead of flying. */

class Bird {
	func fly() {
		print("This bird can fly.")
	}
}

class Penguin: Bird {
	override func fly() {
		print("This bird cannot fly; it swims instead.")
	}
}
/* In this example, you have a base class Bird with a method fly(), which is overridden in the derived class Penguin. While most birds can fly, the Penguin class overrides the fly() method to indicate that it cannot fly and instead swims.

Now, you can demonstrate the Liskov Substitution Principle by using both Bird and Penguin objects interchangeably: */

let genericBird: Bird = Bird()
let penguin: Bird = Penguin()

genericBird.fly() // Output: This bird can fly.
penguin.fly()     // Output: This bird cannot fly; it swims instead.

/* Here, you've created both a generic Bird object and a Penguin object, and you can call the fly() method on both without causing any issues. The program remains correct and doesn't break, even though a Penguin behaves differently when it comes to flying.

This demonstrates the Liskov Substitution Principle. You can use a Penguin (a derived class) in place of a Bird (the base class) without any unexpected consequences, and the behavior remains consistent with what you'd expect from each type of bird. */

// MARK: - INTERFACE SEGREGATION PRINCIPLE
/* The Interface Segregation Principle (ISP) states that clients should not be forced to depend on interfaces they do not use. In other words, interfaces should be small, focused, and specific to the needs of the clients that use them. */

/* Imagine you're building a system for managing electronic devices, and you have a generic Device interface that all devices implement. Initially, this interface has methods for both printing and scanning, which may not be relevant for all types of devices: */

protocol Device {
	func printDocument()
	func scanDocument()
}
/* However, not all devices can both print and scan. Some devices may only be capable of printing, while others may only be capable of scanning. This interface forces all implementing classes to provide implementations for both methods.

To adhere to the Interface Segregation Principle, you can split the Device interface into more specialized interfaces, each focused on a specific aspect of functionality: */

protocol Printer {
	func printDocument()
}

protocol Scanner {
	func scanDocument()
}

/* Now, you have two smaller interfaces: Printer and Scanner, each with a single responsibility.

You can then create classes that implement these interfaces based on their capabilities. For example: */

class LaserPrinter: Printer {
	func printDocument() {
		// Implement printing for a laser printer
	}
}

class FlatbedScanner: Scanner {
	func scanDocument() {
		// Implement scanning for a flatbed scanner
	}
}

class AllInOnePrinterScanner: Printer, Scanner {
	func printDocument() {
		// Implement printing for an all-in-one device
	}

	func scanDocument() {
		// Implement scanning for an all-in-one device
	}
}

/* By separating the Device interface into smaller, more focused interfaces, you allow classes to conform to only the interfaces that are relevant to their specific capabilities. This adheres to the Interface Segregation Principle, as clients are no longer forced to depend on methods they do not use, and the code is more maintainable and flexible. */

// MARK: - DEPENDENCY INVERSION PRINCIPLE
/* The Dependency Inversion Principle (DIP) states that high-level modules should not depend on low-level modules; both should depend on abstractions. Furthermore, abstractions should not depend on details; details should depend on abstractions. This principle promotes decoupling and flexibility in software design. */

/* Suppose you're building a notification system that sends messages to various destinations, such as email and SMS. Initially, you might design your system with a high-level module (NotificationService) that directly depends on low-level modules (EmailService and SMSService). */

class EmailService {
	func sendEmail(message: String, recipient: String) {
		// Send an email
	}
}

class SMSService {
	func sendSMS(message: String, recipient: String) {
		// Send an SMS
	}
}

class NotificationService {
	private let emailService = EmailService()
	private let smsService = SMSService()

	func sendNotification(message: String, recipient: String, viaEmail: Bool) {
		if viaEmail {
			emailService.sendEmail(message: message, recipient: recipient)
		} else {
			smsService.sendSMS(message: message, recipient: recipient)
		}
	}
}

/* In this design, NotificationService directly depends on the concrete implementations of EmailService and SMSService. This violates the Dependency Inversion Principle because the high-level module (NotificationService) depends on low-level details.

To adhere to the Dependency Inversion Principle, you can introduce abstractions and invert the dependencies. Start by defining protocols for the notification services: */

protocol MessageService {
	func sendMessage(message: String, recipient: String)
}

class EmailService1: MessageService {
	func sendMessage(message: String, recipient: String) {
		// Send an email
	}
}

class SMSService1: MessageService {
	func sendMessage(message: String, recipient: String) {
		// Send an SMS
	}
}
/* Now, both EmailService and SMSService conform to the MessageService protocol, which represents an abstraction for sending messages.

Next, modify the NotificationService class to depend on the MessageService protocol: */

class NotificationService1 {
	private let messageService: MessageService

	init(messageService: MessageService) {
		self.messageService = messageService
	}

	func sendNotification(message: String, recipient: String) {
		messageService.sendMessage(message: message, recipient: recipient)
	}
}

/* With this change, NotificationService depends on the MessageService abstraction, and you can inject any class that conforms to this protocol (e.g., EmailService, SMSService) without modifying NotificationService. This adheres to the Dependency Inversion Principle, as high-level and low-level modules both depend on abstractions rather than concrete implementations. This design provides greater flexibility and ease of testing, and it allows you to extend the system with new message services without affecting existing code. */

