////  iAnalyze
////
////  Created by Maciej Jezierski on 19/03/2023.
////

import Foundation

struct Card: Identifiable {
    var id = UUID().uuidString
    var backImage: String
    var frontImage: String

}

func updateImage(card: inout Card, fileName: String) {
    card.frontImage = fileName
}

var cards: [Card] = [Card(backImage: "TDISDI/1", frontImage: "OWSI"),
                      Card(backImage: "TDISDI/2", frontImage: "wreck"),
                      Card(backImage: "TDISDI/3", frontImage: "cave")]

