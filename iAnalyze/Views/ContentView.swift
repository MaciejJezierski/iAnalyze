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
            
            CardStackView()
                .tabItem {
                    Label("Certificates", systemImage: "touchid")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

