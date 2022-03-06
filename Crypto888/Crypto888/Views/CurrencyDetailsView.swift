//
//  CurrencyDetailsView\.swift
//  Crypto888
//
//  Created by Niraj Kumar on 06/03/22.
//

import Foundation
import SwiftUI

struct CurrencyDetailsView: View {
    
    @ObservedObject var viewModel: CurrencyCellViewModel
    
    var body: some View {
        GeometryReader { metrics in
            VStack (alignment: .leading, spacing: 0.0) {
                CurrencyCellView(cellViewModel: viewModel)
                    .frame(height: 50.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.yellow, lineWidth: 1)
                    )
                
                Divider().background(Color.headerbg)
                
                HStack(alignment: .top, spacing: 5) {
                    ColumnText(title: "M. Cap.(%)", value: viewModel.marketCapPercentage24h, alignment: .leading)
                    Spacer()
                    ColumnText(title: "M. Cap.", value: viewModel.marketCapChange24H, alignment: .trailing)
                }
                
                Divider().background(Color.headerbg)
                
                HStack(alignment: .top, spacing: 5) {
                    ColumnText(title: "Price Change(24h)", value: viewModel.priceChange24H, alignment: .leading)
                    Spacer()
                    ColumnText(title: "Total Volume", value: viewModel.totalVolume, alignment: .trailing)
                }
                
                Divider().background(Color.headerbg)
            }.navigationTitle(viewModel.name)
        }
    }
}

// MARK: - Header Title
struct ColumnText: View {
    
    let title: String
    let value: String
    let alignment: HorizontalAlignment
    
    init(title: String, value: String, alignment: HorizontalAlignment) {
        self.title = title
        self.value = value
        self.alignment = alignment
    }
    var body: some View {
        VStack(alignment: self.alignment, spacing: 5){
            Text(title)
                .foregroundColor(Color.change24h)
                .font(Font.system(size: 14).bold())
                .textCase(.uppercase)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .padding(3.0)
            
            Text(value)
                .foregroundColor(Color.price)
                .font(Font.system(size: 14).bold())
                .textCase(.uppercase)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .padding(3.0)
        }
        .padding(5.0)
    }
}
