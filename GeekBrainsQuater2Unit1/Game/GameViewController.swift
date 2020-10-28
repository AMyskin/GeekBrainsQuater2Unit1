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
    
    private let game = Game.shared
    
    weak var gameDelegate: GameViewControllerDelegate?
    weak var gameSceneDelegate: GameViewControllerForSessionDelegate?
    
    private var questions = Question.arrayQuestion
   // private var numberOfQuestion = 0
    
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    @IBOutlet weak var persentLabel: UILabel!
    @IBOutlet weak var totalCountQuestion: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1Label: UIButton!

    @IBOutlet weak var answer2Label: UIButton!
    
    @IBOutlet weak var answer3Label: UIButton!
    
    @IBOutlet weak var answer4Label: UIButton!
    
    
    var onGameEnd: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let numberOfQuestion = self.game.gamesSession?.rightAnswer.value else {return}
        
        questions.append(contentsOf: game.questions)
        game.gamesSession?.questionCount.value = questions.count
        
        let strategy = createStrategy()
        questions = strategy.createQuestion(in: questions)
        
        updateUI(numberOfQuestion: numberOfQuestion)
        
        game.gamesSession?.rightAnswer.addObserver(self, options: [.new, .initial], closure: { [weak self] (questionNumber, _) in
            guard let self = self else { return }
            
            self.numberOfQuestionLabel.text = "Номер Вопроса: \(questionNumber + 1)"
        })
        game.gamesSession?.questionCount.addObserver(self, options: [.new, .initial], closure: { [weak self] (questionCount, _) in
            guard let self = self else { return }
            
            self.totalCountQuestion.text = "Всего вопросов: \(questionCount)"
        })
        game.gamesSession?.persent.addObserver(self, options: [.new, .initial], closure: { [weak self] (persent, _) in
            guard let self = self else { return }
            
            self.persentLabel.text = "Процент: \(persent)"
        })

    }
    
    private func createStrategy() -> QuestionStrategy {
        switch game.difficulty {
        case .easy:
            return SimpleArrayStrategy()
        case  .hard:
            return RandomArrayStrategy()
        }
    }
    
    func getAnswer(_ answerLabel: UIButton, numberOfAnswerButton: Int) -> Bool {

        guard let key = answerLabel.title(for: .normal),
              let numberOfQuestion = self.game.gamesSession?.rightAnswer.value
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
           guard let numberOfQuestion = self.game.gamesSession?.rightAnswer.value else {return}
            
            
            if numberOfQuestion < self.questions.count-1 {
                
                self.gameSceneDelegate?.updateScore(with: numberOfQuestion + 1, totalQuestion: self.questions.count)
 
                
                //self.numberOfQuestion += 1
                
                
            }
            self.updateUI(numberOfQuestion: self.game.gamesSession?.rightAnswer.value ?? 0 )
            self.getPersent()
           // print(self.game.gamesSession?.questionCount)
        }
    }
    
    func gameOver(){
        guard let numberOfQuestion = self.game.gamesSession?.rightAnswer else {return}
        gameDelegate?.didEndGame(with: numberOfQuestion.value, totalQuestion: questions.count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self
            else {return}
            self.getPersent()
            let persent = self.game.gamesSession?.persent.value
            let record = Record(date: Date(), score: String(persent ?? 0))
            self.game.addRecord(record)
            self.game.gamesSession = nil
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getPersent(){
        guard let right = self.game.gamesSession?.rightAnswer.value,
              let allquestion = self.game.gamesSession?.questionCount.value
        else {return}
        
        let persent = right * 100 / allquestion
        self.game.gamesSession?.persent.value = persent
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
        //numberOfQuestionLabel.text = "Вопрос номер \(numberOfQuestion+1) из \(questions.count)"
        
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
