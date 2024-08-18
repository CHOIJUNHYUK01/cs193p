//
//  project_1App.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/11/24.
//

import SwiftUI

@main
struct project_1App: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
