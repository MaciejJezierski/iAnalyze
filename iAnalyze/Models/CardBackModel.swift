////  iAnalyze
////
////  Created by Maciej Jezierski on 19/03/2023.
////

import Foundation

struct CardBack: Identifiable {
    var id = UUID().uuidString
    var image: String
}

var cardBacks: [CardBack] = [CardBack(image: "TDISDI/1"),
                     CardBack(image: "TDISDI/2"),
                     CardBack(image: "TDISDI/3")]
