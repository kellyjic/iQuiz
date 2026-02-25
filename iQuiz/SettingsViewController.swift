//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Kelly Chang on 2026/2/25.
//


import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    let defaultURL = "http://tednewardsandbox.site44.com/questions.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved URL or use default
        let savedURL = UserDefaults.standard.string(forKey: "quizURL")
        urlTextField.text = savedURL ?? defaultURL
    }
    
    @IBAction func checkNowTapped(_ sender: UIButton) {

        guard let urlString = urlTextField.text,
              !urlString.isEmpty else {
            return
        }

        UserDefaults.standard.set(urlString, forKey: "quizURL")

        NotificationCenter.default.post(
            name: NSNotification.Name("ReloadQuizData"),
            object: nil
        )

        self.navigationController?.popViewController(animated: true)
    }
}
