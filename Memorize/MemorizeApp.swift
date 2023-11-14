//
//  MemorizeApp.swift
//  Memorize
//
//  Created by kia on 10/16/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = MemorizeViewModel()
    var body: some Scene {
        WindowGroup {
            MemorizeView(viewModel: game)
        }
    }
}
