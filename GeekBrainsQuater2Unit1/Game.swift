//
//  Game.swift
//  Snake
//
//  Created by Veaceslav Chirita on 10/22/20.
//  Copyright © 2020 Pinspb. All rights reserved.
//

import Foundation

class Game {
    
    static let shared = Game()
    
    var difficulty: Difficulty = .easy

    
    var gamesSession : GameSession?
    
    private let recordCaretaker = RecordsCaretaker()
    
    private(set) var records: [Record] {
        didSet {
            recordCaretaker.save(records: records)
        }
    }
    private(set) var questions: [Question] {
        didSet {
            recordCaretaker.saveQuestion(questions: questions)
        }
    }
    
    private init() {
        records = recordCaretaker.loadRecord()
        questions = recordCaretaker.loadQuestion()
    }
    
    func addRecord(_ record: Record) {
        self.records.append(record)
    }
    
    func addQuestion(_ question: Question){
        self.questions.append(question)
    }
    
    func clearRecords() {
        self.records = []
    }
}
