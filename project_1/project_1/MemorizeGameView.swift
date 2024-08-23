//
//  MemorizeGameView.swift
//  project_1
//
//  Created by CHOIJUNHYUK on 8/11/24.
//

import SwiftUI

struct MemorizeGameView: View {
    @ObservedObject var viewModel: MemorizeGame
    
    @State var themeColor: Color = .red
    
    var body: some View {
        VStack {
            Text(viewModel.selectedTheme)
                .font(.title.bold())
                .textCase(.uppercase)
            
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            HStack {
                Button(action: {
                    viewModel.shuffle()
                }, label: {
                    Text("Shuffle")
                        .frame(minWidth: 120)
                })
                Spacer()
                
                Text("\(viewModel.score)")
                    .font(.title.bold())
                    .frame(maxWidth: 120)
                
                Spacer()
                
                Button(action: {
                    viewModel.newGame()
                }, label: {
                    Text("New Game")
                        .frame(minWidth: 120)
                })
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(themeColor)
    }
}

struct CardView: View {
    let card: MemorizeGameModel<String>.Card
    
    init(_ card: MemorizeGameModel<String>.Card) {
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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    MemorizeGameView(viewModel: MemorizeGame())
}
