//
//  ViewController.swift
//  WordGarden
//
//  Created by Mohsin Braer on 9/13/21.
//

import UIKit
import AVFoundation

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
    
    var audioPlayer: AVAudioPlayer!;
    
    
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
    
    func drawFlowerAndPlaySound(currentLetterGuessed: String)
    {
        if(wordToGuess.contains(currentLetterGuessed) == false){
            wrongGuessesRemaining = wrongGuessesRemaining - 1;
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                UIView.transition(with: self.flowerImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.flowerImageView.image = UIImage(named: "wilt\(self.wrongGuessesRemaining)")}) { _ in
                    
                    if(self.wrongGuessesRemaining != 0){
                        self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)");
                    } else {
                        self.playSound(name: "word-not-guessed");
                        UIView.transition(with: self.flowerImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {                        self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")}, completion: nil)
                    }
                    
                    self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)");
                }
                self.playSound(name: "incorrect");
            }
            
            
        } else
        {
            playSound(name: "correct");
        }
    }
    
    func guessALetter(){
        let currentLetterGuessed = wordGuessText.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed;
        
        formatRevealedWord();
        
        drawFlowerAndPlaySound(currentLetterGuessed: currentLetterGuessed);
        
        //update labels
        guessCount += 1;
        let guesses = ( guessCount == 1 ? "Guess" : "Guesses");
      
        numberGuessesLabel.text = "You've Made \(guessCount) \(guesses)";
        
        
        if (!wordRevealLabel.text!.contains("_"))
        {
            numberGuessesLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word";
            wordsGuessedCount += 1;
            playSound(name: "word-guessed");
            updateAfterWinOrLose();
        } else if wrongGuessesRemaining == 0{
            
            numberGuessesLabel.text = "Game Over! You're all out of guesses";
            wordsMissedCount += 1;
            updateAfterWinOrLose();
        }
        
        
        if(currentWordIndex == wordToGuess.count){
            numberGuessesLabel.text = "\n\nYou've tried all of the words! Restart from the beginning?";
            
        }
        
    }
    
    func playSound(name: String)
    {
        if let sound = NSDataAsset(name: name)
        {
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data);
                audioPlayer.play();}
            catch{
                print("ERROR: \(error.localizedDescription). Could not initialize AVAudioPlayer object");
            }
        } else {
            print("ERROR: Could not read data from file \(name)");
        }
    }

    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        guessLetterButton.isEnabled = !(sender.text!.isEmpty);
        wordGuessText.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces).uppercased();
        
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
        wordRevealLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1);
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
