//
//  MemorizeModel.swift
//  Memorize
//
//  Created by kia on 10/16/23.
//

import Foundation

struct MemorizeModel {
    private(set) var cards: Array<Card>
    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> String) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content : content, id: "\(pairIndex+1)a"))
            cards.append(Card(content : content, id: "\(pairIndex+1)b"))
        }
    }
    

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp}.only
        }
        set {
            cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(_ card: Card) {
        print("Chose \(card)")
        // If chosen card exists
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            // If chosen card is face down and not matched
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                // If we previously chose a card, compare to see if chosen card matches that card
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                // Else, save this card as the first card chosen
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            
        }
    }
    
    
    mutating func shuffle() -> Void{
        cards.shuffle()
        print(cards)
    }
    
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: String
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ?  "matched" : "not matched")"
        }

    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
