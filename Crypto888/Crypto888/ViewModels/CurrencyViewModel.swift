//
//  CurrencyViewModel.swift
//  Crypto888
//
//  Created by Niraj Kumar on 06/03/22.
//

import Combine
import Foundation

final class CurrencyViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var currencies: Currencies = []
    
    @Published private(set) var errorLoadingCurrency: String = ""
    
    @Published private(set) var isFetching: Bool = false
    
    // MARK: -
    
    var currencyCellViewModels: [CurrencyCellViewModel] {
        currencies.map { CurrencyCellViewModel(currency: $0)}
    }
    
    
    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []
    private var page: Int = 1
    
    init() {
        self.page = 1
        self.fetchCurrencies()
    }
    
    // MARK: - Reload the list
    
    func reload() {
        self.page = 1
        self.fetchCurrencies()
    }
    
    // MARK: - call to load next page
    
    func loadMore() {
        self.page = self.page + 1
        self.fetchCurrencies()
    }
    
    // MARK: - Fetch list of crypto currencies from the API
    
    private func fetchCurrencies() {
        let request = URLRequest(url: URL(string: "\(AppSettings.sharedInstance.BASE_URL)/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=\(self.page)&sparkline=false")!)
        
        isFetching = (page == 1)
        print(self.page)
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .map(\.data)
            .decode(type: Currencies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    self?.errorLoadingCurrency = error.localizedDescription
                }
            }) { [weak self] currencies in
                
                if (currencies.isEmpty) {
                    self?.currencies = currencies
                }else {
                    self?.currencies.append(contentsOf: currencies)
                }

            }.store(in: &subscriptions)
    }
}
