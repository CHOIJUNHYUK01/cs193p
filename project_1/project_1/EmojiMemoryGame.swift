//
//  EmojiMemoryGame.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/13/24.
//

import SwiftUI

class EmojiMemoryGame {
    private static let animalEmoji = ["🐶", "🦊", "🐸", "🐥", "🦁", "🐭", "🐧", "🦉", "🐯", "🦄", "🐷", "🐺"]
    private static let personEmoji = ["🧑‍🎄", "🧑‍✈️", "🧑‍🚒", "👩‍🎓", "👨‍🍳", "👨‍🌾", "👨‍🎤", "💂‍♂️", "🕵️"]
    private static let climateEmoji = ["🌪️", "☀️", "🌤️", "🌧️", "❄️", "🌊"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if animalEmoji.indices.contains(pairIndex) {
                return animalEmoji[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
