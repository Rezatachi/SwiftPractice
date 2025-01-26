

# Expense Tracker

An iOS application that helps track and manage your expenses. The app allows users to view their transactions, group them by month, and display relevant details.

## Features

- **Transaction Overview**: Displays a list of recent transactions.
- **Group Transactions by Month**: Groups transactions based on the month they were recorded.
- **Notifications**: Includes a notification icon for upcoming reminders or updates.
  
## Installation

1. Clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/ExpenseTracker.git
```

2. Open the project in Xcode:

```bash
open ExpenseTracker.xcodeproj
```

3. Build and run the project on your simulator or device.

## Usage

### **Group Transactions by Month**

The `groupTransactionsByMonth()` function groups all transactions by their month.

### Code Example:

```swift
func groupTransactionsByMonth() -> TransactionGroup {
    guard !transactions.isEmpty else {
        return [:]  // Return empty dictionary if no transactions
    }
    
    let groupedTransactions = Dictionary(grouping: transactions) { $0.month }  // Group transactions by month
    return groupedTransactions
}
```

### Explanation:
- **`$0.month`**: Shorthand for accessing the `month` property of each transaction. It is used to group transactions by the month they were recorded.

### Example:

```swift
let groupedTransactions = groupTransactionsByMonth()

// Example output:
print(groupedTransactions)
// Output: ["January": [Transaction, Transaction], "February": [Transaction]]
```

---

## Architecture

The app follows a **Model-View-ViewModel (MVVM)** design pattern:
- **Model**: The `Transaction` model represents individual transactions with properties like date, amount, and month.
- **View**: The user interface displays the transactions and transaction details.
- **ViewModel**: Handles business logic, including grouping and sorting transactions.

### **Transaction Model**

```swift
struct Transaction {
    var date: Date
    var amount: Double
    var month: String
}
```

---

## Dependencies

This app doesn't rely on external dependencies (unless specified later).

---

## Contributing

Feel free to fork the project and submit pull requests. Here are some ways you can contribute:
- Add new features
- Report bugs or issues
- Improve documentation

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

