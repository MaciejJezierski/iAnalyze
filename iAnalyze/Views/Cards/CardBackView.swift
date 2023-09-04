//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI

struct CardBackView: View {
    var card: Card
    var body: some View {
        ZStack(alignment: .center) {
            Image(card.backImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                .frame(width: 300, height: 200)
        }
    }
}

struct CardBackView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(card: Card(backImage:"TDISDI/1", frontImage: "sample/cave"))
    }
}
