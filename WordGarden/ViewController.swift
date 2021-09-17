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
    
    
    var wordsToGuess = ["SWIFT", "DOG", "CAT"];
    var currentWordIndex = 0;
    var wordToGuess = "";
    var lettersGuessed = "";
    let maxNumberOfWrongGuesses = 8;
    var wrongGuessesRemaining = 8;
    
    var wordsGuessedCount = 0;
    var wordsMissedCount = 0;
    var guessCount = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = wordGuessText.text!;
        guessLetterButton.isEnabled = !(text.isEmpty);
        wordToGuess = wordsToGuess[currentWordIndex];
        wordRevealLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1);
        
        updateMessageLabels();

    }
    
    func formatRevealedWord()
    {
        var revealWord = ""
        
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealWord = revealWord + "\(letter) ";
            } else{
                revealWord = revealWord + "_ ";
            }
            
        }
        revealWord.removeLast();
        wordRevealLabel.text = revealWord;
    }
    
    func guessALetter(){
        let currentLetterGuessed = wordGuessText.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed;
        
        formatRevealedWord();
        
        if(wordToGuess.contains(currentLetterGuessed) == false){
            wrongGuessesRemaining = wrongGuessesRemaining - 1;
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)");
            
        }
        
        //update labels
        guessCount += 1;
        let guesses = ( guessCount == 1 ? "Guess" : "Guesses");
      
        numberGuessesLabel.text = "You've Made \(guessCount) \(guesses)";
        
        
        if (!wordRevealLabel.text!.contains("_"))
        {
            numberGuessesLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word";
            wordsGuessedCount += 1;
            updateAfterWinOrLose();
        } else if wrongGuessesRemaining == 0{
            
            numberGuessesLabel.text = "Game Over! You're all out of guesses";
            wordsMissedCount -= 1;
            updateAfterWinOrLose();
        }
        
        
        if(currentWordIndex == wordToGuess.count){
            numberGuessesLabel.text = "\n\nYou've tried all of the words! Restart from the beginning?"
            
        }
        
        
        
    }

    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        guessLetterButton.isEnabled = !(sender.text!.isEmpty);
        wordGuessText.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces);
        
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
                
        guessALetter();
        updateUIAfterGuess();
        
    }
    
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
                
        guessALetter();
        updateUIAfterGuess();
        
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        if currentWordIndex == wordToGuess.count{
            currentWordIndex = 0;
            wordsGuessedCount = 0;
            wordsMissedCount = 0;
        }
        
        playAgainButton.isHidden = true;
        wordGuessText.isEnabled = true;
        guessLetterButton.isEnabled = false;
        wordToGuess = wordsToGuess[currentWordIndex];
        wrongGuessesRemaining = maxNumberOfWrongGuesses;
        wordRevealLabel.text = "_" + String(repeating: " _", count: wordsToGuess.count - 1);
        guessCount = 0;
        flowerImageView.image = UIImage(named: "flower\(maxNumberOfWrongGuesses)");
        lettersGuessed = "";
        updateMessageLabels();
        numberGuessesLabel.text = "You've Made Zero Guesses";
        

        
    }
    
    
    func updateMessageLabels()
    {
        wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)";
        wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)";
        wordsRemainingLabel.text = "Words to Guess: \(wordsToGuess.count - (wordsMissedCount + wordsGuessedCount))";
        wordsInGameLabel.text = "Words in Game: \(wordsToGuess.count)";
    }
    
    
    func updateAfterWinOrLose(){
        
        currentWordIndex += 1;
        wordGuessText.isEnabled = false;
        guessLetterButton.isEnabled = false;
        playAgainButton.isHidden = false;
        
        updateMessageLabels();
        

        
    }
    
    
    func updateUIAfterGuess() {
        wordGuessText.resignFirstResponder();
        wordGuessText.text! = "";
        guessLetterButton.isEnabled = false;
    }
    
}
