//
//  Strategies.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 27.10.2020.
//

import Foundation
protocol QuestionStrategy {
    func createQuestion(in questionArray: [Question]) -> [Question]
}
