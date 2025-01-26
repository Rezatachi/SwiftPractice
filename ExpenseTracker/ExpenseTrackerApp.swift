//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionsListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionsListVM)
        }
    }
}
