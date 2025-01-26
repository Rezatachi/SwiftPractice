//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Track Scroll Offset
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0) // Invisible but tracks scrolling
                    
                   
                    
                    // MARK: Recent Transactions List
                    RecentTransactionsList()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color.background)
            .navigationTitle("Overview") // Fixed inline title
            .navigationBarTitleDisplayMode(scrollOffset > -10 ? .large : .inline) // Dynamic switch
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.icon, .primary)
                }
            }
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
            }
        }
    }
}

// MARK: Preference Key for Scroll Offset
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


#Preview {
    let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    ContentView()
        .environmentObject(transactionListVM)
}

#Preview {
    let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    ContentView()
        .preferredColorScheme(.dark)
        .environmentObject(transactionListVM)
}
