//
//  Crypto888App.swift
//  Crypto888
//
//  Created by Niraj Kumar on 06/03/22.
//

import SwiftUI

@main
struct Crypto888App: App {
    var body: some Scene {
        WindowGroup {
            CurrencyContentView(viewModel: CurrencyViewModel())
        }
    }
}
