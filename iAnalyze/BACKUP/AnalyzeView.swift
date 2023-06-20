//
//  AnalyzeView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 12/03/2023.
//

import SwiftUI
import CoreBluetooth

struct AnalyzeView: View {
    let connectionManager = ArduinoConnectionManager()
    @State private var isConnected = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            if isConnected {
                Button("Analyze") {
                    // Trigger Arduino to send an integer value
                    // (Implement the communication code here)
                }
            } else {
                Button("Connect") {
                    // Check if Bluetooth is available
                    guard centralManager.state == .poweredOn else {
                        alertMessage = "Bluetooth unavailable"
                        showAlert = true
                        return
                    }
                    
                    // Show a list of available devices
                    // (Implement the code to show the device list and handle device selection)
                    
                    // After successful connection, set isConnected to true and display "Connected" popup
                    centralManager.connectToD
                    isConnected = true
                    alertMessage = "Connected"
                    showAlert = true
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}
