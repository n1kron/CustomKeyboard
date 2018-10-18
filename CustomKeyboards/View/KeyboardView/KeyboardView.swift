//
//  KeyboardView.swift
//  CustomKeyboards
//
//  Created by  Kostantin Zarubin on 09/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.

import UIKit
import Foundation

class KeyboardView: UIView {
    
    @IBOutlet var keyboardButtons: [UIButton]!
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var capsLockButton: UIButton!
    
    var backgroundNumber = 0
    var userBackground: UIImage!
    
    class func instanceFromNib(VC: UIViewController) -> KeyboardView {
        return UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: VC, options: nil)[0] as! KeyboardView
    }
    
    override func awakeFromNib() {
        
        keyboardButtons.forEach({$0.layer.cornerRadius = 5.0})
        if let userDefaults = UserDefaults(suiteName: "group.com.emojies") {
            if let userBackground = userDefaults.imageForKey(key: "imageDefaults") {
                DispatchQueue.main.async {
                    let image = Crop.cropToBounds(image: userBackground, width:  self.frame.size.width, height: self.frame.size.height)
                    self.backgroundImage.image = image
                }
            } else {
                let index = userDefaults.integer(forKey: "Background")
                let image = Crop.cropToBounds(image: UIImage(named: "background\(index)")!, width:  self.frame.size.width, height: self.frame.size.height)
                backgroundImage.image = image
                DispatchQueue.main.async {
                    if index <= 3 {
                        self.keyboardButtons.forEach({$0.titleLabel?.textColor = UIColor.white})
                        self.keyboardButtons.forEach({$0.setTitleColor(UIColor.black, for: .highlighted)})
                    } else {
                        
                        self.keyboardButtons.forEach({$0.titleLabel?.textColor = UIColor.black})
                        self.keyboardButtons.forEach({$0.setTitleColor(UIColor.white, for: .highlighted)})
                        self.keyboardButtons.forEach({$0.setTitleColor(UIColor.black, for: .normal)})
                    }
                }
            }
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
