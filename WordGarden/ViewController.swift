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
        let text = wordGuessText.text!;
        guessLetterButton.isEnabled = !(text.isEmpty);
        
        
    }
    
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        let text = wordGuessText.text!;
        guessLetterButton.isEnabled = !(text.isEmpty);
        wordGuessText.text = String(text.last ?? " ").trimmingCharacters(in: .whitespaces);
        
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
                
        updateUIAfterGuess();
        
    }
    
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
                
        updateUIAfterGuess();
        
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
    }
    
    func updateUIAfterGuess() {
        wordGuessText.resignFirstResponder();
        wordGuessText.text! = "";
        guessLetterButton.isEnabled = false;
    }
    
}
