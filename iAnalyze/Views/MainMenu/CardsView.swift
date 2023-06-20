//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI

struct CardsView: View {
    @State var expanded: Bool = false
    @State var selectedCard: CardBack?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Color("BG").ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Your Certificates").font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,
                           alignment: expanded ? .leading : .center)
                    .overlay(alignment: .trailing) {
                        Button {
                            withAnimation(.interactiveSpring(response: 0.8,
                                                             dampingFraction: 0.7,
                                                             blendDuration: 0.7)) {
                                expanded = false
                            }
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("Color2"), in: Circle())
                        }
                        .rotationEffect(.init(degrees: expanded ? 45 : 0))
                        .offset(x: expanded ? 10: 15)
                        .opacity(expanded ? 1 : 0)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(cardBacks) { CardBack in
                            Group {
                                if selectedCard?.id == CardBack.id && showDetailCard {
                                    setUpCardView(CardBack: CardBack)
                                        .opacity(0)
                                } else {
                                    setUpCardView(CardBack: CardBack)
                                        .matchedGeometryEffect(id: CardBack.id, in: animation)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    selectedCard = CardBack
                                    showDetailCard = true
                                }
                            }
                        }
                    }
                    .overlay{
                        Rectangle()
                            .fill(.black.opacity(expanded ? 0 : 0.01))
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.35)) {
                                    expanded = true
                                }
                            }
                    }
                    .padding(.top, expanded ? 30 : 0)
                }
                .coordinateSpace(name: "scroll")
                .offset(y: expanded ? 0 : 30)
                Button {
                    withAnimation(.easeOut(duration: 0.35)) {
                        expanded = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color("Color2"), in: Circle())
                }
                .rotationEffect(.init(degrees: expanded ? 180 : 0))
                .scaleEffect(expanded ? 0.01 : 1)
                .opacity(!expanded ? 1 : 0)
                .frame(height: expanded ? 0 : nil)
                .padding(.bottom, expanded ? 0 : 30)
            }
//            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .overlay {
//                if let CardBack = selectedCard, showDetailCard {
//                    DetailView(selectedCard: CardBack,
//                               showDetails: $showDetailCard,
//                               animation: animation)
//                }
//            }
        }
    }
    
    @ViewBuilder
    func setUpCardView(CardBack: CardBack) -> some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("scroll"))
            let offset = CGFloat(getIndexOf(CardBack: CardBack) * (expanded ? 10 : 70))
                CardBackView(CardBack: CardBack)
                .offset(y: expanded ? offset : -rect.minY + offset)
        }
        .frame(height: 210)
    }
    
    func getIndexOf(CardBack: CardBack) -> Int {
        return cardBacks.firstIndex { currentCard in
            return currentCard.id == CardBack.id
        } ?? 0
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}


