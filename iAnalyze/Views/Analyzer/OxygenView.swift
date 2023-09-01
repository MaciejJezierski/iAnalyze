//
//  OxygenView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 20/06/2023.
//
import SwiftUI

struct OxygenView: View {
    @State private var floatValue: Float = 0.0
    @State private var showTextField: Bool = false
    @EnvironmentObject private var bluetoothManager: ArduinoConnectionManager
    
    let floatFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack {
            Button(action: {
                bluetoothManager.startAnalysis(from: bluetoothManager.selectedDevice!)
            }) {
                Text("Analyze")
                    .frame(width: 130, height: 130)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .clipShape(Circle())
            }
            .shadow(radius: 10)
            
            Button(action: {
                bluetoothManager.captureFloatData(from: bluetoothManager.selectedDevice!)
                floatValue = bluetoothManager.receivedValue
                showTextField = true
            }) {
                Text("Read Value")
                    .frame(width: 130, height: 130)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .shadow(radius: 10)
            
            if showTextField {
                Text("Float Value: \(floatValue, specifier: "%.2f")")
                    .padding()
                    .font(.headline)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
        }
    }
}

struct OxygenView_Previews: PreviewProvider {
    static var previews: some View {
        OxygenView()
    }
}
