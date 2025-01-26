//
//  RecentTransactionsList.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//

import SwiftUI

struct RecentTransactionsList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack{
            HStack{
                // MARK: Header Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                // MARK: Header Link
                NavigationLink{
                    TransactionList()
                } label: {
                    HStack(spacing: 4){
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.secondary)
                }
            }
            .padding(.top)
            
            //loop transaction
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id:\.element) {index, 
                transaction in TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x:0, y:5)
    }
}

#Preview {
    let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    RecentTransactionsList()
        .environmentObject(transactionListVM)
}


