//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Kelly Chang on 2026/2/22.
//

import UIKit

class AnswerViewController: UIViewController {

    var quiz: QuizTopic!
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    var wasCorrect: Bool = false

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let question = quiz.questions[currentQuestionIndex]
            
            questionLabel.text = question.text
            
            let correctAnswer = question.answers[question.correctIndex]
            correctAnswerLabel.text = "Correct Answer: \(correctAnswer)"
            
            if wasCorrect {
                resultLabel.text = "You were correct!"
            } else {
                resultLabel.text = "Sorry, that's incorrect."
            }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
    }

    @objc func handleSwipeRight() {
        nextTapped(UIButton())
    }

    @objc func handleSwipeLeft() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {

        let nextIndex = currentQuestionIndex + 1

        if nextIndex < quiz.questions.count {
            performSegue(withIdentifier: "backToQuestion", sender: nextIndex)
        } else {
            performSegue(withIdentifier: "toFinished", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToQuestion" {
            let destination = segue.destination as! QuestionViewController
            
            destination.quiz = quiz
            destination.currentQuestionIndex = sender as! Int
            destination.score = score
        }
        
        if segue.identifier == "toFinished" {
            let destination = segue.destination as! FinishedViewController
            
            destination.quiz = quiz
            destination.score = score
        }
    }
}
