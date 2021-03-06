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
        "animals": ["๐ถ", "๐ฑ", "๐น", "๐ฐ", "๐ฆ", "๐ป", "๐ผ", "๐ปโโ๏ธ", "๐ฏ", "๐ฆ", "๐จ", "๐ฎ"],
        "sports": ["โฝ๏ธ", "๐", "๐", "โพ๏ธ", "๐พ", "๐", "๐ฑ", "๐", "โณ๏ธ", "๐ผ", "๐ฅ", "๐ฅ"],
        "breakfasts": ["๐ฅ", "๐ฅฏ", "๐", "๐ฅ", "๐ฅจ", "๐ฅ", "โ๏ธ", "๐ณ", "๐ง", "๐ฅ", "๐ง", "๐ฅ"],
        "fastfoods": ["๐ญ", "๐", "๐", "๐", "๐ฅช", "๐", "๐ฅค", "๐ฅ", "๐ง", "๐ฆ", "๐ง", "๐ฉ"],
        "vegetables": ["๐ฅ", "๐ง", "๐ง", "๐ฅ", "๐ฝ", "๐ถ", "๐ฅ", "๐ฅฌ", "๐ฅฆ", "๐ฅ", "๐", "๐"],
        "flags": ["๐ณ๏ธโ๐", "๐ฏ๐ต", "๐น๐ญ", "๐ฌ๐ง", "๐ฐ๐ท", "๐ณ๐ฑ", "๐ธ๐ฌ", "๐บ๐ธ", "๐น๐ผ", "๐ฉ๐ช", "๐ง๐ท", "๐ฒ๐ป"],
        "hearts": ["โค๏ธ", "๐งก", "๐", "๐", "๐", "๐ค", "๐", "๐ค", "๐ค", "โค๏ธโ๐ฅ", "๐", "๐"],
    ]
    private var emojiChoices: [String] = ["โค๏ธ", "๐งก", "๐", "๐", "๐", "๐ค", "๐", "๐ค", "๐ค", "โค๏ธโ๐ฅ", "๐", "๐"]
    
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

