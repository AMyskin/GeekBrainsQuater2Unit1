//
//  RandomArray.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 27.10.2020.
//

import UIKit

class RandomArrayStrategy: QuestionStrategy {
    func createQuestion(in questionArray: [Question]) -> [Question]{

        let rand = questionArray.shuffled()
        return rand
    }
    
    
}
