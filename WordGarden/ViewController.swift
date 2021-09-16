//
//  ViewController.swift
//  WordGarden
//
//  Created by Mohsin Braer on 9/13/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsInGameLabel: UILabel!
    
    @IBOutlet weak var wordRevealLabel: UILabel!
    
    @IBOutlet weak var wordGuessText: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    @IBOutlet weak var numberGuessesLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
    }
    
}
