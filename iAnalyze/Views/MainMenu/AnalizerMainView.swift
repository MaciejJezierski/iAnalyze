//
//  AnalizerMainView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 20/06/2023.
//

import SwiftUI

struct AnalizerMainView: View {
    
    @StateObject private var bluetoothManager = ArduinoConnectionManager()
    @State private var isConnected = false
    
    var body: some View {
        VStack {
            if isConnected {
                OxygenView()
                    .environmentObject(bluetoothManager)
            } else {
                ConnectionView { connected in
                    isConnected = connected
                }
                .environmentObject(bluetoothManager)
            }
        }
        .alert(isPresented: $bluetoothManager.isServiceFound) {
                return Alert(
                    title: Text("Service found"),
                    dismissButton: Alert.Button.default(
                        Text("Great!")
                    )
                )
        }
    }
}
