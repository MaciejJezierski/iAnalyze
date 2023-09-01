//
//  DetailView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 26/06/2023.
//

import SwiftUI

struct DetailView: View {
    var selectedCard: Card
    @Binding var showDetails: Bool
    var animation: Namespace.ID
    var body: some View {
        VStack {
            CardFrontView(card: selectedCard)
                .matchedGeometryEffect(id: selectedCard.id, in: animation)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.35)) {
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.35)) {
                        showDetails = false
                        }
                    }
                }
                .padding([.leading, .trailing], 10)
                .zIndex(10)

            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("BG").ignoresSafeArea())

    }
}
