//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Kelly Chang on 2026/2/22.
//

import UIKit

class QuestionViewController: UIViewController {

    var questionIndex = 0
    var correctAnswers = 0
    var quiz: QuizTopic!
    var currentQuestionIndex = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleSwipeRight() {
        submitTapped(UIButton())
    }

    @objc func handleSwipeLeft() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersSegmentedControl: UISegmentedControl!
    
    func loadQuestion() {
        let question = quiz.questions[currentQuestionIndex]
        
        questionLabel.text = question.text
        
        answersSegmentedControl.removeAllSegments()
        
        for (index, answer) in question.answers.enumerated() {
            answersSegmentedControl.insertSegment(withTitle: answer, at: index, animated: false)
        }
        
        answersSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        if answersSegmentedControl.selectedSegmentIndex == -1 {
            return   // nothing selected
        }
        
        let question = quiz.questions[currentQuestionIndex]
        let selectedIndex = answersSegmentedControl.selectedSegmentIndex
        
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
