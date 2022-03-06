//
//  ContentView.swift
//  Crypto888
//
//  Created by Niraj Kumar on 06/03/22.
//

import SwiftUI

struct CurrencyContentView: View {
    
    // MARK: - ViewModel
    
    @ObservedObject var viewModel: CurrencyViewModel
    
    // MARK: - Body
    var body: some View {
        GeometryReader { metrics in
            
            let width = metrics.size.width
            
            NavigationView {
                if viewModel.isFetching {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else if (!viewModel.errorLoadingCurrency.isEmpty) {
                    VStack(alignment: .center, spacing: 5) {
                        Image("ic_no_internet")
                            .tint(Color.error)
                            .frame(width: 30, height: 30, alignment: .center)
                        Text(viewModel.errorLoadingCurrency)
                            .foregroundColor(Color.error)
                            .font(Font.system(size: 14))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .padding(3.0)
                        Button(action: viewModel.reload) {
                            Text("Retry")
                                .foregroundColor(Color.headerfg)
                                .font(Font.system(size: 15).bold())
                                .padding(5.0)
                                .frame(width: metrics.size.width - 20.0, height: 50.0, alignment: .center)
                                .background(Color.symbol)
                        }
                    }.navigationTitle("Crypto Currencies")
                }else {
                    List {
                        Section(
                            
                            // MARK: - Initialie the headerview for the table
                            
                            header: HStack {
                                HeaderText(text: "Name")
                                    .frame(width: (width * 0.4), alignment: .leading)
                                HeaderText(text: "Price")
                                    .frame(width: width * 0.3, alignment: .leading)
                                HeaderText(text: "Change 24H")
                                    .frame(width: width * 0.25, alignment: .leading)
                            }
                                .frame(minWidth: width, minHeight: 40.0, alignment: .leading)
                                .background(Color.headerbg)
                                .padding(5.0),
                            footer: Text("").id(UUID()).onAppear(perform: {
                                viewModel.loadMore()
                            })
                        ) {
                            ForEach(viewModel.currencyCellViewModels) { currency in
                                ZStack {
                                    NavigationLink(destination:CurrencyDetailsView(viewModel: currency)) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                    .navigationViewStyle(.stack)
                                    VStack {
                                        CurrencyCellView(cellViewModel: currency)
                                        Divider()
                                    }
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                .listRowSeparator(.hidden)
                                
                            }
                        }
                    }
                    .id(UUID())
                    .environment(\.defaultMinListRowHeight, 50.0)
                    .listStyle(PlainListStyle())
                    .refreshable {
                        viewModel.reload()
                    }
                    .navigationTitle("Coins")
                }
            }
        }
    }
}

// MARK: - Header Title
struct HeaderText: View {
    let text: String
    init(text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .foregroundColor(Color.headerfg)
            .font(Font.system(size: 12).bold())
            .textCase(.uppercase)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            .padding(3.0)
    }
}
