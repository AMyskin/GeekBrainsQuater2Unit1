//
//  SettingsViewController.swift
//  GeekBrainsQuater2Unit1
//
//  Created by Alexander Myskin on 27.10.2020.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let gameSingleton = Game.shared
    
    @IBOutlet weak var backBattonLabel: UIButton!
    @IBOutlet weak var easyButtonLabel: UIButton!
    @IBOutlet weak var hardButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func back(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func easyButtonPushed(_ sender: UIButton) {
        gameSingleton.difficulty = .easy
        easyButtonLabel.tintColor = .green
        back()
        
    }
    @IBAction func hardButtonPushed(_ sender: UIButton) {
        gameSingleton.difficulty = .hard
        hardButtonLabel.tintColor = .green
        back()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
