//
//  ConnectionView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 12/03/2023.
//

import SwiftUI
import CoreBluetooth

struct ConnectionView: View {
    @EnvironmentObject private var bluetoothManager: ArduinoConnectionManager
    @State private var isConnecting = false
    
    var onConnect: (Bool) -> Void

    var body: some View {
        VStack {
            Button(action: {
                bluetoothManager.startScanning()
            }) {
                Text("Scan for Devices")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            if bluetoothManager.devices.isEmpty {
                Text("No devices found")
            } else {
                List(bluetoothManager.devices, id: \.self) { device in
                    Button(action: {
                        bluetoothManager.connect(to: device)
                        if bluetoothManager.isConnected { isConnecting = true }
    
                    }) {
                        Text(device.name ?? "Unknown Device")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: $bluetoothManager.isConnected) {
            if bluetoothManager.isConnected {
                onConnect(true)
                return Alert(
                    title: Text("Connected to \(bluetoothManager.selectedDevice?.name ?? "Unknown Device")"),
                    dismissButton: .cancel()
                )
            } else {
                return Alert(title: Text("Connection Error"), message: Text("Failed to connect to the device."))
            }
        }
    }
}
