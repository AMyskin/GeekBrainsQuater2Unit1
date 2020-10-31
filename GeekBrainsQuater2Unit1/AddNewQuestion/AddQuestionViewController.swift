//
//  AddQuestionViewController.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 27.10.2020.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var qestionText: UITextField!
    
    @IBOutlet weak var answer1text: UITextField!
    
    @IBOutlet weak var answer2text: UITextField!
    
    @IBOutlet weak var answer3text: UITextField!
    
    @IBOutlet weak var answer4text: UITextField!
    
    @IBOutlet weak var bool1: UISwitch!
    
    @IBOutlet weak var bool2: UISwitch!
    
    @IBOutlet weak var bool3: UISwitch!
    
    @IBOutlet weak var bool4: UISwitch!
    
    
    
  
    @IBAction func answer1bool(_ sender: UISwitch) {
        if sender.isOn {
            bool2.isOn = false
            bool3.isOn = false
            bool4.isOn = false
        }
    }
    @IBAction func answer2bool(_ sender: UISwitch) {
        if sender.isOn {
            bool1.isOn = false
            bool3.isOn = false
            bool4.isOn = false
        }
    }
    @IBAction func answer3bool(_ sender: UISwitch) {
        if sender.isOn {
            bool1.isOn = false
            bool2.isOn = false
            bool4.isOn = false
        }
    }
    @IBAction func answer4bool(_ sender: UISwitch) {
        if sender.isOn {
            bool1.isOn = false
            bool2.isOn = false
            bool3.isOn = false
        }
    }
    
    @IBOutlet weak var question: UITextField!
    

    
    @IBAction func addButtonTapped(_ sender: Any) {
        saveQuestion()
        dismiss(animated: true, completion: nil)
    }
    
    // Проверок никаких нет!!!
    func saveQuestion() {
        guard let question = qestionText.text,
        let answer1 = answer1text.text,
        let answer2 = answer2text.text,
        let answer3 = answer3text.text,
        let answer4 = answer4text.text
        else {return}
        
        let boolSet1 = bool1.isOn
        let boolSet2 = bool2.isOn
        let boolSet3 = bool3.isOn
        let boolSet4 = bool4.isOn
        
        let questionMain = Question(question: question,
                                    answer1: [answer1 : boolSet1],
                                    answer2: [answer2 : boolSet2],
                                    answer3: [answer3 : boolSet3],
                                    answer4: [answer4 : boolSet4])
        //print(questionMain)
        Game.shared.addQuestion(questionMain)
  
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)

    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    @IBAction func scrollTapped(_ gesture: UIGestureRecognizer) {
        scrollView.endEditing(true)
    }
    
    
    
}
