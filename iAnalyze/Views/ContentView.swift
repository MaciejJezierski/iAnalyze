//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnalizerMainView()
                .tabItem {
                    Label("Analyzer", systemImage: "antenna.radiowaves.left.and.right")
                }
            
            PlannerView()
                .tabItem {
                    Label("Calculators", systemImage: "pencil")
                }
            
            CardsView()
                .tabItem {
                    Label("Certificates", systemImage: "touchid")
                }
//            CardFrontView(card: Card(backImage:"TDISDI/1", frontImage: "cave"))
//                .tabItem {
//                    Label("Me", systemImage: "person.crop.square")
//                }
//            CardBackView(CardBack: CardBack(image: "TDISDI/1"))
//                .tabItem {
//                    Label("Me", systemImage: "person.crop.square")
//                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

