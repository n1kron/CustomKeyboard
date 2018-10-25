//
//  ExplanationsViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 05.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import LGButton

class ExplanationsViewController: UIViewController {
    
    @IBOutlet var explanationButtons: LGButton!
    @IBOutlet var explanationLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
