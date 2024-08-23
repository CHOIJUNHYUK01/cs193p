//
//  MemorizaGameApp.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/11/24.
//

import SwiftUI

@main
struct MemorizaGameApp: App {
    @StateObject var game = MemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}
