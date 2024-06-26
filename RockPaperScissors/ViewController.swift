//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Bartolomeo Davide Ventrone on 23/03/24.
//

import UIKit

class ViewController: UIViewController {
    //OUtlets
    @IBOutlet weak var label: UILabel!
    
    //Properties
    var handSelected = false //Indicates whether the user has selected a hand or not
    var myHand = "" //Represents the hand selected by the user
    let hands = ["👊🏼", "✋🏼", "✌🏼","🖖🏼", "🦎"] //Array containing the possible hand choices
    let losesAgainst: [String: Set<String>] = [
        "👊🏼": ["✌🏼", "🦎"], // Rock loses against Scissors and Lizard
        "✋🏼": ["👊🏼", "🖖🏼"], // Paper loses against Rock and Spock
        "✌🏼": ["🖖🏼", "🦎"], // Scissors loses against Spock and Lizard
        "🖖🏼": ["👊🏼", "🦎"], // Spock loses against Rock and Lizard
        "🦎": ["✋🏼", "✌🏼"] // Lizard loses against Paper and Scissors
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Actions associated with the hand selection buttons
    @IBAction func selectRock(_ sender: Any) {
        myHand = "👊🏼"
        handSelected = true
        label.text = "You've selected \(myHand)"
        generateHapticFeedback() // Generates haptic feedback when the user selects a hand
    }
    
    @IBAction func selectPaper(_ sender: Any) {
        myHand = "✋🏼"
        handSelected = true
        label.text = "You've selected \(myHand)"
        generateHapticFeedback() // Generates haptic feedback when the user selects a hand
    }
    
    @IBAction func selectScissors(_ sender: Any) {
        myHand = "✌🏼"
        handSelected = true
        label.text = "You've selected \(myHand)"
        generateHapticFeedback() // Generates haptic feedback when the user selects a hand
    }
    
    @IBAction func selectSpock(_ sender: Any) {
        myHand = "🖖🏼"
        handSelected = true
        label.text = "You've selected \(myHand)"
        generateHapticFeedback() // Generate haptic feedback when user selects a hand
    }
    
    @IBAction func selectLizard(_ sender: Any) {
        myHand = "🦎"
        handSelected = true
        label.text = "You've selected \(myHand)"
        generateHapticFeedback() // Generate haptic feedback when user selects a hand
    }
    
    // Function to generate haptic feedback
    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    // Function to finish the game and display the result
    func finishGame(){
        var message = ""
        let CPUhand = hands.randomElement()! // The hand randomly chosen by the computer
        
        // Check the game result
        if CPUhand == myHand{
          message = "It's a DRAW!"
        }else if losesAgainst[myHand]?.contains(CPUhand) ?? false{
            message = "You Win!"
           
        }else{
            message = "CPU Wins!"
        }
        // Display the game result
        label.text = "You've selected \(myHand)\nCPU selected \(CPUhand)\n\(message)"
    }
    
    
    // Action associated with the play button
    @IBAction func play(_ sender: Any) {
        if handSelected{
            let animationDuration = 5.0 // Duration of the emoji animation (in seconds)
            let animationInterval = 0.5 // Time interval between emoji updates
            
            // Start emoji animation
            var currentIndex = 0
            let timer = Timer.scheduledTimer(withTimeInterval: animationInterval, repeats: true) { timer in
                self.label.text = self.hands[currentIndex % self.hands.count]
                currentIndex += 1
            }
        
            
            // Stop emoji animation after the specified duration
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                timer.invalidate()
                self.finishGame()
            }
            generateHapticFeedback() // Calls the function to finish the game and display the result
        }else{
            label.text = "Please select a hand first!"
        }
    }
}

