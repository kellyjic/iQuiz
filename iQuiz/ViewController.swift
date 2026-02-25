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

struct QuizResponse: Codable {
    let title: String
    let desc: String
    let questions: [QuestionResponse]
}

struct QuestionResponse: Codable {
    let text: String
    let answers: [String]
    let answer: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        
        let defaultURL = "http://tednewardsandbox.site44.com/questions.json"
        fetchQuizzes(from: defaultURL)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadQuizData),
            name: NSNotification.Name("ReloadQuizData"),
            object: nil
        )
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshPulled() {
        let savedURL = UserDefaults.standard.string(forKey: "quizURL") ??
        "http://tednewardsandbox.site44.com/questions.json"
        
        fetchQuizzes(from: savedURL)
        tableView.refreshControl?.endRefreshing()
    }
    
    @objc func reloadQuizData() {
        
        let savedURL = UserDefaults.standard.string(forKey: "quizURL") ??
        "http://tednewardsandbox.site44.com/questions.json"
        
        fetchQuizzes(from: savedURL)
    }

    func fetchQuizzes(from urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
                print("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode([QuizResponse].self, from: data)
                
                let converted = decoded.map { quizResponse in
                    QuizTopic(
                        title: quizResponse.title,
                        description: quizResponse.desc,
                        iconName: "questionmark.circle",
                        questions: quizResponse.questions.map { questionResponse in
                            Question(
                                text: questionResponse.text,
                                answers: questionResponse.answers,
                                correctIndex: Int(questionResponse.answer)! - 1
                            )
                        }
                    )
                }
                
                DispatchQueue.main.async {
                    self.quizzes = converted
                    self.tableView.reloadData()
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
                print("Decoding error: \(error)")
            }
            
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    func showNetworkError() {
        let alert = UIAlertController(
            title: "Network Error",
            message: "Unable to download quizzes.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
        
        let quiz = quizzes[indexPath.row]
        cell.textLabel?.text = quiz.title
        cell.detailTextLabel?.text = quiz.description
        cell.imageView?.image = UIImage(systemName: quiz.iconName)
        
        return cell
    }
    
    var quizzes: [QuizTopic] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestion" {
            
            let destination = segue.destination as! QuestionViewController
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                destination.quiz = quizzes[selectedIndexPath.row]
            }
        }
    }
}
