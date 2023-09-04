//
//  ContentView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import Foundation

struct Card: Identifiable, Equatable {
    static var currentMaxID = -1
    
    var id: Int
    var backImage: String
    var frontImage: String

    init(backImage: String, frontImage: String) {
        Card.currentMaxID += 1
        self.id = Card.currentMaxID
        self.backImage = backImage
        self.frontImage = frontImage
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func saveCardsToFile(cards: [Card]) {
    let fileURL = getDocumentsDirectory().appendingPathComponent("data.txt")
    print("File URL: \(fileURL.path)") // Print the file URL

    let lines = cards.map { "\($0.frontImage),\($0.backImage)" }
    let content = lines.joined(separator: "\n")

    print("Cards data: \(content)") // Print the cards data

    do {
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
        print("File saved successfully") // Print success message
    } catch {
        print("Error saving file: \(error)") // Print error message
    }
}

func loadCardsFromFile() -> [Card] {
    let fileURL = getDocumentsDirectory().appendingPathComponent("data.txt")
    
    do {
        let cardData = try String(contentsOf: fileURL, encoding: .utf8)
        let cardLines = cardData.split(separator: "\n")
        
        return cardLines.map { line in
            let cardImages = line.split(separator: ",")
            return Card(backImage: String(cardImages[1]), frontImage: String(cardImages[0]))
        }
    } catch {
        print("Error loading cards: \(error)")
        return []
    }
}

//sample cards for views testing
//var cards: [Card] = [Card(backImage: "TDISDI/1", frontImage: "cave"),
//                      Card(backImage: "TDISDI/2", frontImage: "wreck"),
//                      Card(backImage: "TDISDI/3", frontImage: "cave"),Card(backImage: "TDISDI/1", frontImage: "OWSI"),
//                     Card(backImage: "TDISDI/2", frontImage: "wreck"),
//                     Card(backImage: "TDISDI/3", frontImage: "cave"),]
//
//saveCardsToFile (cards: cards)
