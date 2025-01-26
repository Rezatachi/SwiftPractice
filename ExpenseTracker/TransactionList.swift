//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionsListVM: TransactionListViewModel
    var body: some View {
        VStack{
            List {
                ForEach(Array(transactionsListVM.groupTranasactionsByMonth()), id: \.key) {
                    month, transactions in
                    Section {
                        ForEach(transactions) {
                            transactions in TransactionRow(transaction: transactions)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                    
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Transasctions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    NavigationView {
     TransactionList()
            .environmentObject(transactionListVM)
    }
}
