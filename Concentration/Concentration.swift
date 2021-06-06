//
//  Concentration.swift
//  Concentration
//
//  Created by asmb on 1/6/2564 BE.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    private var numberOfPairsOfCards: Int
    
    public var score = 0
    
    private mutating func mismatchPenalize(at index: Int) {
        if (cards[index].hasBeenSeen) {
            score -= 1
        } else {
            cards[index].hasBeenSeen = true
        }
    }
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    mismatchPenalize(at: index)
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
                mismatchPenalize(at: index)
            }
            cards[index].isFaceUp = true
        }
    }
    
    public mutating func resetGame() {
        cards = [Card]()
        indexOfOneAndOnlyFaceUpCard = nil
        score = 0
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        resetGame()
    }
}
