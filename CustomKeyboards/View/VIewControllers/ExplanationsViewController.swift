//
//  ExplanationsViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 05.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class ExplanationsViewController: UIViewController {
    
    @IBOutlet var explanationButtons: [UIButton]!
    @IBOutlet var explanationLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in explanationButtons {
            button.layer.cornerRadius = 10.0
        }
    }
    
    @IBAction func setupAction(_ sender: Any) {
        guard let profileUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(profileUrl) {
            UIApplication.shared.open(profileUrl, completionHandler: { (success) in
            })
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
