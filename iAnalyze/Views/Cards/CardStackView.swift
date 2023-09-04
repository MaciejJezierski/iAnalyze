//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI

struct CardStackView: View {
    @State private var expanded: Bool = false
    @State private var selectedCard: Card?
    @Namespace private var animation
    
    @State private var cards: [Card] = loadCardsFromFile()
    
    init() {
        // Check if the "data.txt" file exists, if not, create sample data and save it to the file
        let fileURL = getDocumentsDirectory().appendingPathComponent("data.txt")

            let sampleCards: [Card] = [Card(backImage: "TDISDI/1", frontImage: "cave"),
                                       Card(backImage: "TDISDI/2", frontImage: "wreck"),
                                       Card(backImage: "TDISDI/3", frontImage: "cave"),
                                       Card(backImage: "TDISDI/1", frontImage: "OWSI"),
                                       Card(backImage: "TDISDI/2", frontImage: "wreck"),
                                       Card(backImage: "TDISDI/3", frontImage: "cave")]
            saveCardsToFile(cards: sampleCards)
            cards = sampleCards

    }
    
    var body: some View {
        ZStack {
            
            Color(red: 180/255, green: 224/255, blue: 232/255).ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Your Certificates")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                
                ScrollView(.vertical, showsIndicators: false) {
                    cardStackView
                }
                .coordinateSpace(name: "scroll")
                .offset(y: expanded ? 0 : 30)
                
                
            }
            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if expanded {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.35)) {
                        expanded = false
                    }
                }) {
                    Image(systemName: "arrow.up")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.green, in: Circle())
                }
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    private var cardStackView: some View {
        VStack(spacing: 0) {
            ForEach(cards) { card in
                cardView(for: card)
            }
        }
        .padding(.top, expanded ? 30 : 0)
        .overlay(
            Rectangle()
                .fill(Color.black.opacity(expanded ? 0 : 0.01))
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.35)) {
                        expanded = true
                    }
                }
        )
    }
    
    private func cardView(for card: Card) -> some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("scroll"))
            let offset = CGFloat(getIndexOf(card: card) * (expanded ? 5 : 20)) // Change the multiplier values to adjust the stacking distance
            
            if let index = cards.firstIndex(where: { $0.id == card.id }) {
                CardView(cards: $cards, card: $cards[index], canFlip: true)
                    .offset(x: (rect.width - 300) / 2, y: expanded ? offset : -rect.minY + offset)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            selectedCard = card
                        }
                    }
            }
        }
        .frame(height: 210)
    }
    
    private func getIndexOf(card: Card) -> Int {
        return cards.firstIndex { currentCard in
            return currentCard.id == card.id
        } ?? 0
    }
}
struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
