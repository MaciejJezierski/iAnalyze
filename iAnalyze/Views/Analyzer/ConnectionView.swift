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
    @State private var NotYetSearched = true

    
    var onConnect: (Bool) -> Void

    var body: some View {
        VStack {
            Button(action: {
                bluetoothManager.startScanning()
                NotYetSearched = false
            }) {
                Text("Scan for Devices")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            if !NotYetSearched{
                if bluetoothManager.devices.isEmpty {
                    Text("No devices found \(String(bluetoothManager.devices.isEmpty))")
                } else {
                    List(bluetoothManager.devices, id: \.self) { device in
                        Button(action: {
                            if(!bluetoothManager.isConnected){bluetoothManager.connect(to: device)}
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
        }
        .padding()
        .alert(isPresented: $bluetoothManager.isConnected) {
            if bluetoothManager.isConnected {
                
                return Alert(
                    title: Text("Connected to \(bluetoothManager.selectedDevice?.name ?? "Unknown Device")"),
                    dismissButton: Alert.Button.default(
                        Text("Great!"), action: {onConnect(true)}
                    )
                )
            } else {
                return Alert(title: Text("Connection Error"), message: Text("Failed to connect to the device."))
            }
        }
    }
}
