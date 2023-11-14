//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by kia on 10/16/23.
//

import Foundation

class MemorizeViewModel : ObservableObject{
    private static let emojis = ["🩷" ,"❤️","🧡", "💛", "💚", "🩵" ,"💙", "💜", "🖤", "🩶", "🤍" , "🤎"]
    
    private static func createMemoryModel() -> MemorizeModel {
        return MemorizeModel(numberOfPairsOfCards: 8) {pairIndex in
            if emojis.indices.contains(pairIndex) { 
                return emojis[pairIndex]
            } else {
                return "❌"
            }
            
        }
    }
    
    @Published private var model = createMemoryModel()
   
    
    var cards:Array<MemorizeModel.Card>{
        return model.cards
    }
    
    // MARK : - Intents
    
    func shuffle() -> Void{
        model.shuffle()
    }
    
    func choose( _ card: MemorizeModel.Card){
        model.choose(card)
    }
    
    
}
