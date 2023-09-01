//
//  PlannerView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 12/03/2023.
//

import SwiftUI

struct PlannerView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                NavigationLink(destination: CalculateMODView()) {
                    Text("Calculate MOD")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: CalculateNDLView()) {
                    Text("Calculate NDL")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: CalculateBestMixView()) {
                    Text("Calculate Best MIX")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: CalculateEADView()) {
                    Text("Calculate EAD")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("NITROX Calculators")
                        .font(.headline)
                }
            }
        }
    }
}


struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}

