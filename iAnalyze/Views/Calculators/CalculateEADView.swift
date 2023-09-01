//
//  CalculateEADView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 01/09/2023.
//

import SwiftUI

struct CalculateEADView: View {
    @State private var nitroxValue: Int = 21
    @State private var depthIntegerValue: Int = 0
    @State private var depthDecimalValue: Int = 0

    var depthValue: Double {
        Double(depthIntegerValue) + Double(depthDecimalValue) / 10
    }

    var eadValue: Double {
        (((1 - Double(nitroxValue) / 100) * (depthValue + 10)) / 0.79) - 10
    }

    var body: some View {
        VStack {
            Text("Choose nitrox")
                .font(.headline)
            Picker("NITROX", selection: $nitroxValue) {
                ForEach(21...100, id: \.self) { value in
                    Text("\(value)").tag(value)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)

            Text("Choose depth")
                .font(.headline)
            HStack {
                Picker("Depth Integer", selection: $depthIntegerValue) {
                    ForEach(0..<101) { value in
                        Text("\(value)").tag(value)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)

                Text(".")

                Picker("Depth Decimal", selection: $depthDecimalValue) {
                    ForEach(0..<10) { value in
                        Text("\(value)").tag(value)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 50, height: 100)
            }

            Text("EAD value for NITROX \(nitroxValue) and depth of \(String(format: "%.1f", depthValue))m is \(String(format: "%.1f", eadValue))")
            Spacer()
        }
        .padding()
        .navigationBarTitle("Calculate EAD", displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("EAD calculator")
                    .font(.system(size: 34, weight: .bold))
            }
        }
    }
}
struct CalculateEADView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateEADView()
    }
}
