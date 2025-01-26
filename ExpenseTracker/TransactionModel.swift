//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//

import Foundation
import SwiftUIFontIcon

struct Transaction: Identifiable, Decodable, Hashable {
    
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParse()
    }
    
    var signedAmount: Double {
        isExpense ? -amount : amount
    }
    
    var month: String {
        
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType: String {
    
    case debit = "Debit"
    case credit = "Credit"
}


    



