//
//  ViewController.swift
//  Concentration
//
//  Created by asmb on 1/6/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emoji = [Card:String]()
    private let themes: [String:[String]] = [
        "animals": ["🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐯", "🦁", "🐨", "🐮"],
        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏓", "⛳️", "🛼", "🥋", "🥊"],
        "breakfasts": ["🥐", "🥯", "🍞", "🥖", "🥨", "🥚", "☕️", "🍳", "🧈", "🥞", "🧇", "🥛"],
        "fastfoods": ["🌭", "🍔", "🍟", "🍕", "🥪", "🍗", "🥤", "🥓", "🧋", "🍦", "🧀", "🍩"],
        "vegetables": ["🥔", "🧅", "🧄", "🥕", "🌽", "🌶", "🥒", "🥬", "🥦", "🥑", "🍅", "🍆"],
        "flags": ["🏳️‍🌈", "🇯🇵", "🇹🇭", "🇬🇧", "🇰🇷", "🇳🇱", "🇸🇬", "🇺🇸", "🇹🇼", "🇩🇪", "🇧🇷", "🇲🇻"],
        "hearts": ["❤️", "🧡", "💛", "💚", "💙", "🖤", "💜", "🤍", "🤎", "❤️‍🔥", "💖", "💘"],
    ]
    private var emojiChoices: [String] = ["❤️", "🧡", "💛", "💚", "💙", "🖤", "💜", "🤍", "🤎", "❤️‍🔥", "💖", "💘"]
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "flip: \(flipCount)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "score: \(score)"
        }
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
        
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomTheme()
    }

    @IBAction func flipCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func StartNewGame(_ sender: UIButton) {
        flipCount = 0
        randomTheme()
        game.resetGame()
        updateViewFromModel()
    }
    
    private func randomTheme() {
        let themeKeys = Array(themes.keys)
        let randomThemeIndex = themeKeys.count.arc4random
        let randomTheme = themeKeys[randomThemeIndex]
        emojiChoices = themes[randomTheme]!
    }
    
    func updateViewFromModel() {
        score = game.score
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0) : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }
        }
    }
        
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

