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
        ZStack(alignment: .top) {
            if let image = scannedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .padding([.top], 30)
                    .frame(maxWidth: .infinity)
            } else {
                Image(card.frontImage)
                    .resizable()
                     .aspectRatio(contentMode: .fit)
                     .cornerRadius(15)
                     .padding([.top], 30)
                     .frame(maxWidth: .infinity)
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    isShowingScanner = true
                }) {
                    Text("Change")
                        .frame(width: 130, height: 130)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                .shadow(radius: 10)
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            IDScannerView(scannedImage: $scannedImage)
        }
    }
}

// IDScannerView code from the previous response

//struct CardFrontView_Previews: View {
//    var body: some View {
//        CardFrontView(card: Card(backImage:"TDISDI/1", frontImage: "sample/cave"))
//    }
//}
