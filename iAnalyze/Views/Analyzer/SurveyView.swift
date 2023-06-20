//
//  SurveyView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 20/06/2023.
//
import SwiftUI

struct OxygenView: View {
    @State private var floatValue: Float = 1.2
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
                bluetoothManager.captureFloatData()
                floatValue = bluetoothManager.receivedValue
                showTextField = true
            }) {
                Text("Analyze")
                    .frame(width: 130, height: 130)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .clipShape(Circle())
            }
            .shadow(radius: 10)
            
            if showTextField {
                TextField("Float Value", value: $floatValue, formatter: floatFormatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.headline)
                    .keyboardType(.decimalPad)
            }
        }
    }
}
