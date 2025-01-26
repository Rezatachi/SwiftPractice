//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//


import Foundation
import SwiftUI

// This is just used to display data in the preview, and won't be in the productionbuild

var transacationPreviewData = Transaction(id: 1, date: "2065-01-25", institution: "Chase", account: "Checking", merchant: "Apple Store", amount: 999.99, type: "debit", categoryId: 1, category: "Electronics", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transacationPreviewData, count: 10)
