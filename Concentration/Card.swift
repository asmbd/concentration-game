//
//  Card.swift
//  Concentration
//
//  Created by asmb on 1/6/2564 BE.
//

import Foundation

struct Card: Hashable
{
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    var identifier: Int
    
    func hash(into hasher: inout Hasher) {
       hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
