//
//  Question.swift
//  geekBrainsQuarter2
//
//  Created by Alexander Myskin on 22.10.2020.
//

import Foundation

struct Question: Codable {
    
    let question: String
    let answer1: [String: Bool]
    let answer2: [String: Bool]
    let answer3: [String: Bool]
    let answer4: [String: Bool]
    
    static let arrayQuestion: [Question] = [
        Question(question: "Чем в давние веремени бил холоп, обращаясь к царю?",
                 answer1: ["плечом" : false],
                 answer2: ["челом": true],
                 answer3: ["веслом": false],
                 answer4: ["кнутом": false]),
        Question(question: "Как звали пиратского капитана, сыгранного Джонни Деппом?",
                 answer1: ["Джек Воробей": true],
                 answer2: ["Джон Прохиндей": false],
                 answer3: ["Перт Варфоломей": false],
                 answer4: ["Кислотный Диджей": false]),
        Question(question: "Чем способен \"стрелять\" хамелеон?",
                 answer1: ["хвостом": false],
                 answer2: ["языком": true],
                 answer3: ["глазами": false],
                 answer4: ["слюной": false]),
        Question(question: "Какого цвета были волосы у Пеппи Длинный чулок?",
                 answer1: ["черные": false],
                 answer2: ["каштановые": true],
                 answer3: ["пепельные": false],
                 answer4: ["рыжие": true]),
        Question(question: "Что не входит в комплекс Тадж-Махал?",
                 answer1: ["минареты": false],
                 answer2: ["сад": true],
                 answer3: ["фонтаны": false],
                 answer4: ["обсерватория": true]),
    ]
    
}
