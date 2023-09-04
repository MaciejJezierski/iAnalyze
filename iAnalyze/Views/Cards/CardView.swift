//
//  CardView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 03/09/2023.
//

import SwiftUI
import VisionKit

struct CardView: View {
    @State private var isFlipped = true
    @State private var scannedImage: UIImage? {
        didSet {
            if let image = scannedImage {
                let fileName = "\(card.id).jpg"
                let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
                
                if let data = image.jpegData(compressionQuality: 1.0) {
                    try? data.write(to: fileURL)
                    card.frontImage = fileName
                    saveCardsToFile(cards: cards)
                }
            }
        }
    }
    
    @State private var showScanner = false

    @Binding var cards: [Card]
    @Binding var card: Card
    var canFlip = true
    
    var body: some View {
        ZStack {
            CardFrontView(card: card)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(isFlipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))

            CardBackView(card: card)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            if canFlip {
                withAnimation(.linear(duration: 0.3)) {
                    isFlipped.toggle()
                }
            }
        }
        .onLongPressGesture {
            showScanner = true
        }
        .sheet(isPresented: $showScanner) {
            IDScannerView(scannedImage: $scannedImage)
        }
    }
}
