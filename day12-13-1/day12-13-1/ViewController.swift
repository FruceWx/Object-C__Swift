//
//  ViewController.swift
//  day12-13-1
//
//  Created by 魏雄飞 on 2016/12/13.
//  Copyright © 2016年 Fruce.Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resuletLabel: UILabel!
    
    @IBOutlet weak var guessdeTextField: UITextField!
    
    var lowerBound = 0
    var upperBound = 100
    var numGuesses = 0
    var secretNumber = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guessdeTextField.becomeFirstResponder()
        reset()
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        guard let number = Int(guessdeTextField.text!) else {
            let alert = UIAlertController(title: nil, message: "Enter a number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        selectedNumber(number)
    }
    
    @IBAction func replay(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        guard let number = Int(guessdeTextField.text!) else {
            let alert = UIAlertController(title: nil, message: "Enter a number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        selectedNumber(number)
    }
    
}


    
    
private extension ViewController {
    enum Comparison {
        case smaller
        case greater
        case equals
    }

    func compareNumber(_ number: Int, otherNumber: Int) -> Comparison {
        if number < otherNumber {
            return .smaller
        } else if number > otherNumber {
            return .greater
        }
        return .equals
    }
    
    func selectedNumber(_ number: Int) {
        switch compareNumber(number, otherNumber: secretNumber) {
        case .equals:
            let alert = UIAlertController(title: nil, message: "You won in \(numGuesses) guesses!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {haha in
                self.reset()
                self.guessdeTextField.text = ""
            }))
            self.present(alert, animated: true, completion: nil)
        case .smaller:
            lowerBound = max(lowerBound, number)
            numGuesses += 1
            resuletLabel.text = "Your last guess was too low \n" + renderNumGuesses()
            
            renderRange()
            
        case .greater:
            upperBound = min(upperBound, number)
            numGuesses += 1
            resuletLabel.text = "Your last guess was too high \n" + renderNumGuesses()
            
            renderRange()
            
        
        }
        
    }
    
    
}
    
private extension ViewController {
    func extractSecretNumber() {
        let diff = upperBound - lowerBound
        let randomNumber = Int(arc4random_uniform(UInt32(diff)))
        secretNumber = randomNumber + Int(lowerBound)
        
        
    }
    
    func renderRange() {
        
    }
    
    func renderNumGuesses() ->String {
        return "Number of Guesses: \(numGuesses)"
    }
    
    func resetData() {
        lowerBound = 0
        upperBound = 100
        numGuesses = 0
    }
    
    func resetMsg() {
        resuletLabel.text = ""
    }
    
    func reset() {
        resetData()
        renderRange()
        
        extractSecretNumber()
        resetMsg()
    }
    
}
    
    






