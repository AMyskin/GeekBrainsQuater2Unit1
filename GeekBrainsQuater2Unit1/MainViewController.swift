//
//  ViewController.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 25.10.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showGame":
            let gameSession = GameSession()
            Game.shared.gamesSession = gameSession
            
            guard let destination = segue.destination as? GameViewController else { return }
            destination.gameDelegate = self
            destination.gameSceneDelegate = gameSession
           
        default:
            break
        }
    }
    
    @IBAction func newGameDidTap(_ sender: UIButton) {
        performSegue(withIdentifier: "showGame", sender: self)
    }


}

extension MainViewController : GameViewControllerDelegate {

    
    func didEndGame(with score: Int, totalQuestion: Int) {
        
        self.resultLabel.text = "Последний результат:  \(score*100 / totalQuestion)%"
    }
    
    
}

