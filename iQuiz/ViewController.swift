//
//  ViewController.swift
//  iQuiz
//
//  Created by Kelly Chang on 2026/2/15.
//

import UIKit

struct QuizTopic {
    let title: String
    let description: String
    let iconName: String
    let questions: [Question]
}

struct Question {
    let text: String
    let answers: [String]
    let correctIndex: Int
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        
//        let quiz = quizzes[indexPath.row]
//        cell.textLabel?.text = quiz.title
//        cell.detailTextLabel?.text = quiz.description
//        cell.imageView?.image = UIImage(systemName: quiz.iconName)
//        
//        return cell
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
        
        let quiz = quizzes[indexPath.row]
        cell.textLabel?.text = quiz.title
        cell.detailTextLabel?.text = quiz.description
        cell.imageView?.image = UIImage(systemName: quiz.iconName)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toQuestion", sender: self)
//    }
//    
    var quizzes: [QuizTopic] = [
        QuizTopic(
                title: "Mathematics",
                description: "Test your math skills.",
                iconName: "plus.circle",
                questions: [
                            Question(
                                text: "What is 2 + 2?",
                                answers: ["3", "4", "5"],
                                correctIndex: 1
                            ),
                            Question(
                                text: "What is 5 × 3?",
                                answers: ["15", "10", "20"],
                                correctIndex: 0
                            ),
                            Question(
                                text: "What is 10 ÷ 2?",
                                answers: ["2", "5", "8"],
                                correctIndex: 1
                            ),
                            Question(
                                text: "What is 9 - 4?",
                                answers: ["3", "4", "5"],
                                correctIndex: 2
                            )
                        ]
            ),
        QuizTopic(title: "Marvel Super Heroes",
                  description: "How well do you know Marvel?",
                  iconName: "bolt.circle",
                  questions: [
                              Question(
                                  text: "Who is Loki's brother?",
                                  answers: ["Thor", "Hulk", "Iron Man"],
                                  correctIndex: 0
                              ),
                              Question(
                                  text: "What is Captain America's shield made of?",
                                  answers: ["Adamantium", "Vibranium", "Steel"],
                                  correctIndex: 1
                              ),
                              Question(
                                  text: "Who sacrificed themselves so Thanos could obtain the Soul Stone?",
                                  answers: ["Gamora", "Black Widow", "Nebula"],
                                  correctIndex: 0
                              ),
                              Question(
                                      text: "Which Infinity Stone does Vision have?",
                                      answers: ["Time Stone", "Mind Stone", "Reality Stone"],
                                      correctIndex: 1
                                  ),
                              Question(
                                  text: "Who sacrificed themselves so the Avengers could obtain the Soul Stone?",
                                  answers: ["Gamora", "Black Widow", "Scarlet Witch"],
                                  correctIndex: 1
                              )
                          ]
                 ),
        
        QuizTopic(title: "Science",
                  description: "Explore scientific knowledge.",
                  iconName: "atom",
                  questions: [
                    Question(text: "What is the periodic table element Symbol for Gold?", answers: ["Ag", "Au", "Gd"], correctIndex: 1),
                    Question(
                            text: "Which layer of Earth is the hottest?",
                            answers: ["Crust", "Mantle", "Core"],
                            correctIndex: 2
                        ),
                    Question(
                        text: "What type of energy is stored in a stretched rubber band?",
                        answers: ["Kinetic Energy", "Thermal Energy", "Potential Energy"],
                        correctIndex: 2
                    )
                  ]
                  
                  
                 )
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings",
                                      message: "Settings go here",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestion" {
            
            let destination = segue.destination as! QuestionViewController
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                destination.quiz = quizzes[selectedIndexPath.row]
            }
        }
    }
}
