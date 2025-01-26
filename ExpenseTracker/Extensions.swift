//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//


import Foundation
import SwiftUI

extension Color {
    
    static let backgroundC = Color("Background")
    static let iconC = Color("Icon")
    static let textC = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String{
    func dateParse() -> Date {
        guard let parseDate = DateFormatter.allNumericUSA.date(from: self) else {
            return Date()
        }
        return parseDate
    }
}
