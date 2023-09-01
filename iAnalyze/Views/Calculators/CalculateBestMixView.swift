//
//  CalculateBestMixView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 01/09/2023.
//

import SwiftUI

struct CalculateBestMixView: View {
    @State private var modValue: Int = 0
    @State private var ppIntegerValue: Int = 1
    @State private var ppDecimalValue: Int = 0

    var ppValue: Double {
        Double(ppIntegerValue) + Double(ppDecimalValue) / 10
    }

    var nitroxValue: Int {
        let rawValue = (ppValue / ((Double(modValue) / 10) + 1)) * 100
        return Int(rawValue.rounded())
    }

    var body: some View {
        VStack {
            Text("Choose MOD")
                .font(.headline)
            Picker("MOD", selection: $modValue) {
                ForEach(0..<101) { value in
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

            Text("Best mix for MOD \(modValue) and maximum PPO2 of \(String(format: "%.1f", ppValue)) is NITROX \(nitroxValue)")
            Spacer()
        }
        .padding()
        .navigationBarTitle("Calculate Best Mix", displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Best MIX calculator")
                    .font(.system(size: 34, weight: .bold))
            }
        }
    }
}


struct CalculateBestMixView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateBestMixView()
    }
}
