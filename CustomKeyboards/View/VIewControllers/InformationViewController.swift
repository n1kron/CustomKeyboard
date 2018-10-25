//
//  InformationViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 05.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import StoreKit

class InformationViewController: UIViewController {
    
    @IBOutlet var infoButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in infoButtons {
            button.layer.cornerRadius = 10
            button.layer.borderColor = button.titleLabel?.textColor.cgColor
            button.layer.borderWidth = 2.0
        }
    }
    
    @IBAction func rateAction(_ sender: Any) {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            UIApplication.shared.open(URL(string: "")!, options: [:], completionHandler: nil) // add ref
        }
    }
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
        openUrl(urlString: "http://emodji.website/politics-emodji.html")
    }
    
    @IBAction func termOfUseAction(_ sender: Any) {
        openUrl(urlString: "http://emodji.website/politics-emodji1.html")
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let shareText = "" // add ref
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
