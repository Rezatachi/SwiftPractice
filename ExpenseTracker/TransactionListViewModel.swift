//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Abraham Belayneh on 1/25/25.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]
final class TransactionListViewModel: ObservableObject{
    // This allows a publisher that gives every user that uses this state, an update viewpoint of the data
    
    // This is response for sendeing updates to subscribers
    @Published var transactions: [Transaction] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(){
        getTransactions()
    }
    
    func getTransactions() {
        // grab data from .json file
        let urlString = "https://designcode.io/data/transactions.json"
        fetchTransactions(from: urlString)
    }
    
    private func fetchTransactions(from urlString: String){
        guard let url = URL(string: urlString) else {
            print("Invalid URL String \(urlString)")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{(data, response) in
                try self.validateResponse(data, response)}
            .decode(type: [Transaction].self ,decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleRecievedData)
            .store(in: &cancellables)
    }
    
    private func validateResponse(_ data: Data, _ response: URLResponse) throws -> Data {
        guard response is HTTPURLResponse else {
            dump(response)
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure(let error):
            print("Failed to fetch data: \(error.localizedDescription)")
        case .finished:
            print("Data fetched Succesfully")
        }
    }
    
    private func handleRecievedData(_ transactions: [Transaction]) {
        self.transactions = transactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
    
        guard !transactions.isEmpty else {
            return []
        }
        
        let today = "02/17/2022".dateParse()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!

        
        var sum: Double = .zero
        var cumSum = TransactionPrefixSum()
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
           
            let dailyExpenses = self.transactions.filter({ $0.isExpense })
                .filter({ $0.date.dateParse() == date })

            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount}
            sum += dailyTotal
            sum = sum.roundedToTwoDecimals()
 
            cumSum.append((date.formatted(), sum))

        }
        
        return cumSum
    }
    
    func groupTranasactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {
            return [:]
        }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month}
        return groupedTransactions
    }
                    
}
