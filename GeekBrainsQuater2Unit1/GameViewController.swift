//
//  GameViewController.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 25.10.2020.
//

import UIKit

protocol GameViewControllerForSessionDelegate: class {
    func updateScore(with score: Int, totalQuestion: Int)
}

protocol GameViewControllerDelegate: class {
    func didEndGame(with score: Int, totalQuestion: Int)
}

class GameViewController: UIViewController {
    
    let game = Game.shared
    
    weak var gameDelegate: GameViewControllerDelegate?
    weak var gameSceneDelegate: GameViewControllerForSessionDelegate?
    
    private let questions = Question.arrayQuestion
   // private var numberOfQuestion = 0
    
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1Label: UIButton!

    @IBOutlet weak var answer2Label: UIButton!
    
    @IBOutlet weak var answer3Label: UIButton!
    
    @IBOutlet weak var answer4Label: UIButton!
    
    
    var onGameEnd: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let numberOfQuestion = self.game.gamesSession?.rightAnswer else {return}
        game.gamesSession?.questionCount = questions.count
        updateUI(numberOfQuestion: numberOfQuestion)

    }
    
    func getAnswer(_ answerLabel: UIButton, numberOfAnswerButton: Int) -> Bool {

        guard let key = answerLabel.title(for: .normal),
              let numberOfQuestion = self.game.gamesSession?.rightAnswer
        else {return false}
        
        
       
        switch numberOfAnswerButton {
      
        case 1:
            return questions[numberOfQuestion].answer1[key]! ? true : false
        case 2:
            return questions[numberOfQuestion].answer2[key]! ? true : false
        case 3:
            return questions[numberOfQuestion].answer3[key]! ? true : false
        case 4:
            return questions[numberOfQuestion].answer4[key]! ? true : false
        default:
            return false
        }
        
    }
    
    func nextQuestion(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else {return}
           guard let numberOfQuestion = self.game.gamesSession?.rightAnswer else {return}
            
            if numberOfQuestion < self.questions.count-1 {
                
                self.gameSceneDelegate?.updateScore(with: numberOfQuestion + 1, totalQuestion: self.questions.count)
 
                
                //self.numberOfQuestion += 1
                
                
            }
            self.updateUI(numberOfQuestion: self.game.gamesSession?.rightAnswer ?? 0 )
           // print(self.game.gamesSession?.questionCount)
        }
    }
    
    func gameOver(){
        guard let numberOfQuestion = self.game.gamesSession?.rightAnswer else {return}
        gameDelegate?.didEndGame(with: numberOfQuestion, totalQuestion: questions.count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else {return}
            let score = self.game.gamesSession?.persent ?? ""
            let record = Record(date: Date(), score: score)
            self.game.addRecord(record)
            self.game.gamesSession = nil
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func answer1Push(_ sender: UIButton) {
        if getAnswer(sender, numberOfAnswerButton: 1) {
            answer1Label.tintColor = .green
            nextQuestion()

           
        } else{
            answer1Label.tintColor = .red
            gameOver()
        }
        //answer1Label.tintColor = getAnswer(sender, numberOfAnswerButton: 1) ? .red : .green
    }
    

    
    @IBAction func answer2Push(_ sender: UIButton) {
        if getAnswer(sender, numberOfAnswerButton: 2) {
            answer2Label.tintColor = .green
            nextQuestion()
        } else{
            answer2Label.tintColor = .red
            gameOver()
        }
    }
    @IBAction func answer3Push(_ sender: UIButton) {
        if getAnswer(sender, numberOfAnswerButton: 3) {
            answer3Label.tintColor = .green
            nextQuestion()
        } else{
            answer3Label.tintColor = .red
            gameOver()
        }
    }
    @IBAction func answer4Push(_ sender: UIButton) {
        if getAnswer(sender, numberOfAnswerButton: 4) {
            answer4Label.tintColor = .green
            nextQuestion()
        } else{
            answer4Label.tintColor = .red
            gameOver()
        }
    }
    
    func updateUI(numberOfQuestion: Int){
        numberOfQuestionLabel.text = "Вопрос номер \(numberOfQuestion+1) из \(questions.count)"
        questionLabel.text = questions[numberOfQuestion].question
        let firstAnswer = questions[numberOfQuestion].answer1.keys.first
        answer1Label.setTitle(firstAnswer, for: .normal)
        answer1Label.tintColor = .black
        let secondAnswer = questions[numberOfQuestion].answer2.keys.first
        answer2Label.setTitle(secondAnswer, for: .normal)
        answer2Label.tintColor = .black
        let thirdAnswer = questions[numberOfQuestion].answer3.keys.first
        answer3Label.setTitle(thirdAnswer, for: .normal)
        answer3Label.tintColor = .black
        let fouthAnswer = questions[numberOfQuestion].answer4.keys.first
        answer4Label.setTitle(fouthAnswer, for: .normal)
        answer4Label.tintColor = .black
    }
    

    

  

}
