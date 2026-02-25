//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Kelly Chang on 2026/2/22.
//

import UIKit

class QuestionViewController: UIViewController {

    var quiz: QuizTopic!
    var currentQuestionIndex = 0
    var score = 0
    var selectedAnswerIndex: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let buttons = [button1, button2, button3, button4]

        for button in buttons {
            button?.titleLabel?.numberOfLines = 0
            button?.titleLabel?.textAlignment = .center
            button?.isSelected = false
        }
        
    }
    
    @objc func handleSwipeRight() {
        submitTapped(UIButton())
    }

    @objc func handleSwipeLeft() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    
    func loadQuestion() {
        let question = quiz.questions[currentQuestionIndex]
        
        questionLabel.text = question.text
        
        let buttons = [button1, button2, button3, button4]
        
        for i in 0..<buttons.count {
            if i < question.answers.count {
                buttons[i]?.setTitle(question.answers[i], for: .normal)
                buttons[i]?.isHidden = false
            } else {
                buttons[i]?.isHidden = true
            }
        }
        
        selectedAnswerIndex = nil
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        let buttons = [button1, button2, button3, button4]
        
        for (index, button) in buttons.enumerated() {
            if button == sender {
                selectedAnswerIndex = index
                button?.isSelected = true
            } else {
                button?.isSelected = false
            }
        }
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        
        guard let selectedIndex = selectedAnswerIndex else {
            return
        }
        
        let question = quiz.questions[currentQuestionIndex]
        let isCorrect = selectedIndex == question.correctIndex
        
        if isCorrect {
            score += 1
        }
        
        performSegue(withIdentifier: "toAnswer", sender: isCorrect)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            
            let destination = segue.destination as! AnswerViewController
            
            destination.quiz = quiz
            destination.currentQuestionIndex = currentQuestionIndex
            destination.score = score
            destination.wasCorrect = sender as! Bool
        }
    }
    
}
