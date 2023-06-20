//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI

struct CardFrontView: View {
    var CardFront: CardFront
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        Text(CardFront.fed)
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .center, spacing: 5) {
                            Text("Validity")
                                .font(.caption)
                                .foregroundColor(.white)
                            Text(CardFront.cert)
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing], 30)
                    
                }
                .frame(maxWidth: .infinity, minHeight: 150)
                .background(.green.opacity(0.2))
                
            }
            .background(.green.opacity(0.2))
            .cornerRadius(25)
        }
    }
    

}

struct CardFrontView_Previews: PreviewProvider {
    static var previews: some View {
        CardFrontView(CardFront: CardFront(fed: "SDI",
                                           cert: "OWD"))
    }
}
