//
//  CurrencyViewModel.swift
//  Crypto888
//
//  Created by Niraj Kumar on 06/03/22.
//

import Foundation
import Combine
import SwiftUI

internal final class CurrencyCellViewModel: ObservableObject, Identifiable {
    
    // MARK: - Properties
    
    let currency: Currency
    
    // MARK: - id
    
    var id: String {
        currency.id
    }

    // MARK: - name
    
    var name: String {
        currency.name ?? ""
    }
    
    // MARK: - symbol
    
    var symbol: String {
        currency.symbol ?? ""
    }
    
    // MARK: - image path
    
    var image: String {
        currency.image ?? ""
    }
    
    // MARK: - Price
    
    var currentPrice: String {
        String(format: "%@ %.2f", AppSettings.sharedInstance.APP_CURRENCY, currency.currentPrice ?? 0.0)
    }
    
    var priceChangePercentage24H: String {
        String(format:"%.4f%@", currency.priceChangePercentage24H ?? 0.0, "%")
    }
    
    var marketCapPercentage24h: String {
        String(format:"%lf%@", currency.marketCapChangePercentage24H ?? 0.0, "%")
    }
    
    var marketCapChange24H: String {
        String(format:"%@ %.4f", AppSettings.sharedInstance.APP_CURRENCY, currency.marketCapChange24H ?? 0.0)
    }
    
    var totalVolume: String {
        String(format:"%@ %.4f", AppSettings.sharedInstance.APP_CURRENCY, currency.totalVolume ?? 0.0)
    }
    
    var priceChange24H: String {
        String(format:"%@ %.4f", AppSettings.sharedInstance.APP_CURRENCY, currency.priceChange24H ?? 0.0)
    }
    
    // MARK: - Initialization
    
    init(currency: Currency) {
        self.currency = currency
    }
    
}
