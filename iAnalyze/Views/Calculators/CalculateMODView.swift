//
//  CalculateMODView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 01/09/2023.
//

import SwiftUI

struct CalculateMODView: View {
    @State private var nitroxValue: Int = 21
    @State private var ppIntegerValue: Int = 1
    @State private var ppDecimalValue: Int = 0

    var ppValue: Double {
        Double(ppIntegerValue) + Double(ppDecimalValue) / 10
    }

    var modValue: Double {
        let rawValue = ((10 * ppValue) / (Double(nitroxValue) / 100)) - 10
        return floor(rawValue)
    }

    var body: some View {
        VStack {
            Text("Choose NITROX")
                .font(.headline)
            Picker("NITROX", selection: $nitroxValue) {
                ForEach(21...100, id: \.self) { value in
                    Text("\(value)").tag(value)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)

            Text("Choose maximum O2 PP")
                .font(.headline)
            HStack {
                Picker("PP Integer", selection: $ppIntegerValue) {
                    ForEach(1..<11) { value in
                        Text("\(value)").tag(value)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)

                Text(".")

                Picker("PP Decimal", selection: $ppDecimalValue) {
                    ForEach(0..<10) { value in
                        Text("\(value)").tag(value)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 50, height: 100)
            }

            Text("MOD for NITROX \(nitroxValue) and maximum PPO2 of \(String(format: "%.1f", ppValue)) is \(String(format: "%.0f", modValue))")
            Spacer()
        }
        .padding()
        .navigationBarTitle("Calculate MOD", displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MOD calculator")
                    .font(.system(size: 34, weight: .bold))
            }
        }
    }
}

struct CalculateMODView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateMODView()
    }
}
