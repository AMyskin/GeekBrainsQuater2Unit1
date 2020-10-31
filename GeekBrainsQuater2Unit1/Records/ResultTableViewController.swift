//
//  ResultTableViewController.swift
//  Snake
//
//  Created by Veaceslav Chirita on 10/22/20.
//  Copyright © 2020 Pinspb. All rights reserved.
//

import UIKit

class ResultTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
        tableView.delegate = self
        tableView.dataSource = self

    }

}

extension ResultTableViewController: UITableViewDelegate {
    
}

extension ResultTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordTableViewCell
            else { return UITableViewCell() }
        let record = Game.shared.records[indexPath.row]
        
        cell.recordLabel.text = "\(record.score)"
        cell.dateLabel.text = record.date.description
        
        return cell
    }
    
    
}
