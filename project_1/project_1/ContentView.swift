//
//  ContentView.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    let animalEmoji = ["🐶", "🦊", "🐸", "🐥", "🦁", "🐭", "🐧", "🦉", "🐯", "🦄", "🐷", "🐺"]
    let personEmoji = ["🧑‍🎄", "🧑‍✈️", "🧑‍🚒", "👩‍🎓", "👨‍🍳", "👨‍🌾", "👨‍🎤", "💂‍♂️", "🕵️"]
    let climateEmoji = ["🌪️", "☀️", "🌤️", "🌧️", "❄️", "🌊"]
    
    @State var selectedTheme = "Animal"
    @State var cachedEmojis: [String] = []
    @State var cardCount = 6
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle.bold())
            ScrollView {
                cards
            }
            Spacer()
            cardThemeAdjusters
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
        let cardPairs = emojis.flatMap { [$0, $0] }
        return cardPairs.shuffled()
    }

    func updateCachedEmojis() {
        switch selectedTheme {
        case "Animal":
            cachedEmojis = createShuffledPairs(from: animalEmoji)
        case "Person":
            cachedEmojis = createShuffledPairs(from: personEmoji)
        case "Climate":
            cachedEmojis = createShuffledPairs(from: climateEmoji)
        default:
            cachedEmojis = createShuffledPairs(from: animalEmoji)
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 64))]) {
            ForEach(0..<cachedEmojis.count, id: \.self) { index in
                CardView(content: cachedEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.red)
    }
    
    var cardThemeAdjusters: some View {
        HStack {
            Spacer()
            Spacer()
            animalThemeChanger
            Spacer()
            personThemeChanger
            Spacer()
            climateThemeChanger
            Spacer()
            Spacer()
        }
    }
    
    func cardThemeAdjuster(name title: String, symbol: String) -> some View {
        Button(action: {
            updateTheme(to: title)
        }, label: {
            VStack(spacing: 4) {
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
                Text(title)
                    .font(.body)
            }
        })
        .frame(minWidth: 80)
    }
    
    var animalThemeChanger: some View {
        cardThemeAdjuster(name: "Animal", symbol: "dog.circle")
    }
    
    var personThemeChanger: some View {
        cardThemeAdjuster(name: "Person", symbol: "person.circle")
    }
    
    var climateThemeChanger: some View {
        cardThemeAdjuster(name: "Climate", symbol: "cloud.circle")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
