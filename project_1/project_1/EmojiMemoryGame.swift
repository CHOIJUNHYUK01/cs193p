//
//  EmojiMemoryGame.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/13/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let animalEmoji = ["🐶", "🦊", "🐸", "🐥", "🦁", "🐭", "🐧", "🦉", "🐯", "🦄", "🐷", "🐺"]
    private static let personEmoji = ["🧑‍🎄", "🧑‍✈️", "🧑‍🚒", "👩‍🎓", "👨‍🍳", "👨‍🌾", "👨‍🎤", "💂‍♂️", "🕵️"]
    private static let climateEmoji = ["🌪️", "☀️", "🌤️", "🌧️", "❄️", "🌊"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if animalEmoji.indices.contains(pairIndex) {
                return animalEmoji[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var color: Color {
        .red
    }
    
    // MARK: Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
