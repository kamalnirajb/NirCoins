//
//  CurrencyCellView.swift
//  Crypto888
//
//  Created by Niraj Kumar on 06/03/22.
//

import Foundation
import SwiftUI

struct CurrencyCellView: View {
    
    @ObservedObject var cellViewModel: CurrencyCellViewModel
    
    var body: some View {
        GeometryReader { metrics in
            
            // Calculate the parent width
            let width = metrics.size.width - 10.0
            
            VStack (alignment: .leading, spacing: 0.0) {
                HStack {
                    HStack {
                        if !cellViewModel.image.isEmpty {
                            AsyncImage(url: URL(string: cellViewModel.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Color.image
                            }
                            .frame(width: 30.0, height: 30.0, alignment: .center)
                            .mask(RoundedRectangle(cornerRadius: 15.0))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(cellViewModel.name)
                                .font(Font.system(size: 16.0).bold())
                                .scaledToFit()
                                .minimumScaleFactor(0.5)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color.name)
                            Text(cellViewModel.symbol)
                                .textCase(.uppercase)
                                .font(Font.system(size: 13.0))
                                .foregroundColor(Color.symbol)
                        }
                    }.frame(width: (width * 0.4), alignment: .leading)
                    
                    Text(cellViewModel.currentPrice)
                        .font(Font.system(size: 14.0).bold())
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.price)
                        .frame(width: width * 0.3, alignment: .leading)
                    
                    Text(cellViewModel.priceChangePercentage24H)
                        .textCase(.uppercase)
                        .font(Font.system(size: 14.0).bold())
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.change24h)
                        .frame(width: width * 0.25, alignment: .trailing)
                    
                }
            }
            .padding(5.0)
        }
    }
}
