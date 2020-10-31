//
//  RecordsCaretaker.swift
//  Snake
//
//  Created by Veaceslav Chirita on 10/22/20.
//  Copyright © 2020 Pinspb. All rights reserved.
//

import Foundation

class RecordsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "results"
    private let keyQuestion = "questions"
    
    
    func saveQuestion(questions: [Question]) {
        do {
            let data = try encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: keyQuestion)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestion() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: keyQuestion) else {
            return []
        }
        
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func save(records: [Record]) {
        do {
            let data = try encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadRecord() -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([Record].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
