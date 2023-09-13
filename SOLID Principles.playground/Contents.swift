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
