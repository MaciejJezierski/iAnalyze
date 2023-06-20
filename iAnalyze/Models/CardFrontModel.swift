////  iAnalyze
////
////  Created by Maciej Jezierski on 19/03/2023.
////

import Foundation

struct CardFront: Identifiable {
    var id = UUID().uuidString
//    var certNumber: String
//    var instNumber: String
//    var birthDate: Date
//   var certDate: Date
    var fed: String
    var cert: String
}

var cardFronts: [CardFront] = [CardFront(fed: "SDI",
                          cert: "OWD"),
                          CardFront(fed: "SDI",
                          cert: "AOWD"),
                          CardFront(fed: "SDI",
                          cert: "DM")]
