//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI

struct CardBackView: View {
    var CardBack: CardBack
    var body: some View {
        ZStack(alignment: .center) {
                    
                    Image(CardBack.image)
                        .cornerRadius(15)
                        .padding([.top], 30)
                        .frame(maxWidth: .infinity)
        }
    }
    

}

struct CardBackView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(CardBack: CardBack(image: "TDISDI/1"))
    }
}
