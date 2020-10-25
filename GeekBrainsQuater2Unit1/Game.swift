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

    
    var gamesSession : GameSession?
    
    private let recordCaretaker = RecordsCaretaker()
    
    private(set) var records: [Record] {
        didSet {
            recordCaretaker.save(records: records)
        }
    }
    
    private init() {
        records = recordCaretaker.loadRecord()
    }
    
    func addRecord(_ record: Record) {
        self.records.append(record)
    }
    
    func clearRecords() {
        self.records = []
    }
}
