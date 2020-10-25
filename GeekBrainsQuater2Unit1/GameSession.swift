//
//  GameSession.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 25.10.2020.
//

import Foundation

class GameSession {
    
    var questionCount = 0
    var rightAnswer = 0
    var persent : String {
        return "\(rightAnswer * 100 / questionCount)%"
    }
    
 

    
    
}

extension GameSession : GameViewControllerForSessionDelegate {
    func updateScore(with score: Int, totalQuestion: Int) {
        self.questionCount = totalQuestion
        self.rightAnswer = score
    }
    

    
 
    
    
}
