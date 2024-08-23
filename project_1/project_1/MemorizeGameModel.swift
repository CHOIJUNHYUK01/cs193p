//
//  MemorizeGameModel.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/23/24.
//

import Foundation

struct MemorizeGameModel<CardContent> where CardContent: Equatable {
    private static func createGame(using numberOfPairsOfCards: Int, by cardContentFactory: (Int) -> CardContent) -> [Card] {
        var tempCards: [Card] = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            tempCards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            tempCards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        
        return tempCards.shuffled()
    }
    
    private(set) var cards: [Card]
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Self.createGame(using: numberOfPairsOfCards, by: cardContentFactory)
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0 )} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hadShown || cards[potentialMatchIndex].hadShown {
                            score -= 1
                        }
                        cards[chosenIndex].hadShown = true
                        cards[potentialMatchIndex].hadShown = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func suffle() {
        cards.shuffle()
    }
    
    mutating func newGame(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Self.createGame(using: numberOfPairsOfCards, by: cardContentFactory)
    }
    
    struct Card: Identifiable, Equatable {
        var isFaceUp = false
        var isMatched = false
        var hadShown = false
        let content: CardContent
        
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
