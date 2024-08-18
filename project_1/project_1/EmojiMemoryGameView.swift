//
//  EmojiMemoryGameView.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/11/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    let animalEmoji = ["🐶", "🦊", "🐸", "🐥", "🦁", "🐭", "🐧", "🦉", "🐯", "🦄", "🐷", "🐺"]
    let personEmoji = ["🧑‍🎄", "🧑‍✈️", "🧑‍🚒", "👩‍🎓", "👨‍🍳", "👨‍🌾", "👨‍🎤", "💂‍♂️", "🕵️"]
    let climateEmoji = ["🌪️", "☀️", "🌤️", "🌧️", "❄️", "🌊"]
    
    // Device orientation is monitored using Environment's size classes
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State var selectedTheme = "Animal"
    @State var cachedEmojis: [String] = []
    @State var themeColor: Color = .red
    
    private var isPortrait: Bool {
        horizontalSizeClass == .compact && verticalSizeClass == .regular
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle.bold())
            ScrollView {
                cards
            }
            .scrollDisabled(isPortrait)
            Spacer()
            cardThemeChangers
        }
        .padding()
        .onAppear {
            updateCachedEmojis()
        }
    }
    
    func updateTheme(to theme: String) {
        if selectedTheme != theme {
            selectedTheme = theme
        }
        updateCachedEmojis()
    }
    
    func createShuffledPairs(from emojis: [String]) -> [String] {
        let randomEmojis = emojis.shuffled()[0...Int.random(in: 1..<emojis.count)]
        let cardPairs = randomEmojis + randomEmojis
        return cardPairs.shuffled()
    }
    
    func updateCachedEmojis() {
        switch selectedTheme {
        case "Person":
            cachedEmojis = createShuffledPairs(from: personEmoji)
            themeColor = .blue
        case "Climate":
            cachedEmojis = createShuffledPairs(from: climateEmoji)
            themeColor = .green
        default:
            cachedEmojis = createShuffledPairs(from: animalEmoji)
            themeColor = .red
        }
    }
    
    // Calculate the number of columns for the grid based on the card count
    private func adaptiveGridItemColumns() -> [GridItem] {
        let width = UIScreen.main.bounds.width
        let optimalWidth = widthThatBestFits(cardCount: cachedEmojis.count, screenWidth: width)
        return [GridItem(.adaptive(minimum: optimalWidth))]
    }
    
    // Calculate the best fitting card width based on the number of cards and screen width
    private func widthThatBestFits(cardCount: Int, screenWidth: CGFloat) -> CGFloat {
        let baseWidth: CGFloat = screenWidth / CGFloat(ceil(sqrt(Double(cardCount))) + 1)
        
        if isPortrait {
            return max(64, baseWidth)
        } else {
            return 64
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundStyle(themeColor)
    }
    
    var cardThemeChangers: some View {
        HStack {
            Spacer()
            Spacer()
            animalThemeSetter
            Spacer()
            personThemeSetter
            Spacer()
            climateThemeSetter
            Spacer()
            Spacer()
        }
    }
    
    func cardThemeChanger(to label: String, symbol: String) -> some View {
        Button(action: {
            updateTheme(to: label)
        }, label: {
            VStack(spacing: 4) {
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.title)
                Text(label)
                    .font(.caption)
            }
        })
        .frame(minWidth: 32)
    }
    
    var animalThemeSetter: some View {
        cardThemeChanger(to: "Animal", symbol: "dog.circle")
    }
    
    var personThemeSetter: some View {
        cardThemeChanger(to: "Person", symbol: "person.circle")
    }
    
    var climateThemeSetter: some View {
        cardThemeChanger(to: "Climate", symbol: "cloud.circle")
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
