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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let quiz = quizzes[indexPath.row]
        cell.textLabel?.text = quiz.title
        cell.detailTextLabel?.text = quiz.description
        cell.imageView?.image = UIImage(systemName: quiz.iconName)
        
        return cell
    }
    
    var quizzes: [QuizTopic] = [
        QuizTopic(title: "Mathematics",
                  description: "Test your math skills.",
                  iconName: "plus.circle"),
        
        QuizTopic(title: "Marvel Super Heroes",
                  description: "How well do you know Marvel?",
                  iconName: "bolt.circle"),
        
        QuizTopic(title: "Science",
                  description: "Explore scientific knowledge.",
                  iconName: "atom")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings",
                                      message: "Settings go here",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

}

