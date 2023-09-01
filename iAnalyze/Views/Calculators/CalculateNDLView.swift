//
//  CalculateNDLView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 01/09/2023.
//

import SwiftUI

struct CalculateNDLView: View {
    @State private var nitroxValue: Int = 32 {
        didSet {
            if oldValue != nitroxValue {
                depthIndex = 0
            }
        }
    }
    @State private var depthIndex: Int = 0

    let depthsForNitrox32 = [14, 16, 18, 20, 22, 24, 26, 30, 36, 40]
    let depthsForNitrox36 = [16, 18, 20, 22, 24, 26, 28, 30, 34]
    let ndlForNitrox32 = [205, 130, 95, 75, 60, 50, 40, 30, 20, 16]
    let ndlForNitrox36 = [185, 125, 95, 70, 60, 50, 40, 35, 28]

    var depthValue: Int {
        if nitroxValue == 32 {
            return depthsForNitrox32[depthIndex]
        } else {
            return depthsForNitrox36[depthIndex]
        }
    }

    var ndlValue: Int {
        if nitroxValue == 32 {
            return ndlForNitrox32[depthIndex]
        } else {
            return ndlForNitrox36[depthIndex]
        }
    }

    var body: some View {
        VStack {
            Text("Choose NITROX")
                .font(.headline)
            Picker("NITROX", selection: $nitroxValue) {
                Text("32").tag(32)
                Text("36").tag(36)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Text("Choose depth")
                .font(.headline)
            Picker("DEPTH", selection: $depthIndex) {
                if nitroxValue == 32 {
                    ForEach(0..<depthsForNitrox32.count) { index in
                        Text("\(depthsForNitrox32[index])").tag(index)
                    }
                } else {
                    ForEach(0..<depthsForNitrox36.count) { index in
                        Text("\(depthsForNitrox36[index])").tag(index)
                    }
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)

            Text("NDL for NITROX \(nitroxValue) and depth of \(depthValue)m is \(ndlValue) min")
            Spacer()
        }
        .padding()
        .navigationBarTitle("Calculate NDL", displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("NDL calculator")
                    .font(.system(size: 34, weight: .bold))
            }
        }
    }
}

struct CalculateNDLView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateNDLView()
    }
}
