import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State private var scrollOffset: CGFloat = 0
    @EnvironmentObject var transactionListVM: TransactionListViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) { // No `.leading` alignment to keep content centered
                    
                    // MARK: Track Scroll Offset
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0) // Invisible but tracks scrolling

                    // MARK: Transactions Chart with Timeline
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format:"$%0.2f")
                                LineChart()
                                
                            }
                            .background(Color.systemBackground)
                            
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height:300)
                    }
                    
                    

                    // MARK: Recent Transactions List
                    RecentTransactionsList()
                }
                .padding(.horizontal, 16) // Ensure consistent padding
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color.background)
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(scrollOffset > -10 ? .large : .inline)
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
        .accentColor(.primary)
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
