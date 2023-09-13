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
