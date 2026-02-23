//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Kelly Chang on 2026/2/22.
//
import UIKit

class FinishedViewController: UIViewController {
    
    var quiz: QuizTopic!
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let total = quiz.questions.count
        
        scoreLabel.text = "You got \(score!) out of \(total) correct."
        
        if score == total {
            messageLabel.text = "Perfect!"
        } else if score >= total / 2 {
            messageLabel.text = "Almost!"
        } else {
            messageLabel.text = "Better luck next time!"
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
