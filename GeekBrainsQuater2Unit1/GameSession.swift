//
//  GameSession.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 25.10.2020.
//

import Foundation

class GameSession {
    
    var questionCount = Observable<Int>(0)
    var rightAnswer = Observable<Int>(0)
    var persent = Observable<Int>(0)
    //String {
        //return "\(rightAnswer * 100 / questionCount)%"
   // }
    
 

    
    
}

extension GameSession : GameViewControllerForSessionDelegate{
    func updateScore(with score: Int, totalQuestion: Int) {
        self.questionCount.value = totalQuestion
        self.rightAnswer.value = score
    }
    

    
 
    
    
}
