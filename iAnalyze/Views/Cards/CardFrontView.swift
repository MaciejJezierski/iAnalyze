//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI
import VisionKit

struct CardFrontView: View {
    @State private var scannedImage: UIImage?
    @State private var isShowingScanner = false
    var card: Card

    var body: some View {
        ZStack(alignment: .center) {

                Image(card.frontImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .frame(width: 300, height: 200)
            }
        }
}


struct CardFrontView_Previews: PreviewProvider {
    static var previews: some View {
        CardFrontView(card: Card(backImage:"TDISDI/1", frontImage: "cave"))
    }
}

