//
//  MemorizeGame.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/23/24.
//

import Foundation

class MemorizeGame: ObservableObject {
    private static let emojis = [
        "animal": ["🐶", "🦊", "🐸", "🐥", "🦁", "🐭", "🐧", "🦉", "🐯", "🦄", "🐷", "🐺"],
        "person": ["🧑‍🎄", "🧑‍✈️", "🧑‍🚒", "👩‍🎓", "👨‍🍳", "👨‍🌾", "👨‍🎤", "💂‍♂️", "🕵️"],
        "climate": ["🌪️", "☀️", "🌤️", "🌧️", "❄️", "🌊"],
        "ball": ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
        "heart": ["🩷", "❤️", "🧡", "💛", "💚", "🩵", "💙"],
        "flag": ["🏴‍☠️", "🇺🇳", "🇬🇭", "🇬🇾", "🏁", "🇰🇷", "🇩🇪", "🇱🇷"]
    ]
    
    private static func generateGameModel() -> (model: MemorizeGameModel<String>, theme: String) {
        let themeIndex = Int.random(in: 0..<emojis.count)
        
        for (offset, element) in emojis.enumerated() {
            if offset == themeIndex {
                let model = MemorizeGameModel(numberOfPairsOfCards: Int.random(in: 1..<12)) { pairIndex in
                    if element.value.indices.contains(pairIndex) {
                        return element.value[pairIndex]
                    } else {
                        return element.value[Int.random(in: 0..<element.value.count)]
                    }
                }
                return (model, element.key)
            }
        }
        // Fallback in case no theme is selected (shouldn't happen in practice with the current logic)
        return (MemorizeGameModel(numberOfPairsOfCards: 1) { _ in "❓" }, "default")
    }
    
    private static func createMemorizeGame() -> MemorizeGameModel<String> {
        return generateGameModel().model
    }
    
    @Published private var model: MemorizeGameModel<String>
    @Published private(set) var selectedTheme: String
    
    init() {
        let result = MemorizeGame.generateGameModel()
        self.model = result.model
        self.selectedTheme = result.theme
    }
    
    var cards: Array<MemorizeGameModel<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    func choose(_ card: MemorizeGameModel<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.suffle()
    }
    
    func newGame() {
        let result = Self.generateGameModel()
        model = result.model
        selectedTheme = result.theme
    }
}
