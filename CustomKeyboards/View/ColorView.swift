//
//  ColorView.swift
//  CustomKeyboards
//
//  Created by  Kostantin Zarubin on 18/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

protocol ColorDelegate: class {
    func changeFontColor(color: UIColor)
}

class ColorView: UIView {
    
    @IBOutlet var colorButtons: [UIButton]!
    weak var delegate: ColorDelegate?
    
    override func awakeFromNib() {
        self.frame = CGRect(x:0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 3)
        colorButtons.forEach({$0.layer.cornerRadius = 10.0})
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
    }
    
    func animShow(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    @IBAction func changeColorAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            sender.alpha = 0.1
        }, completion: {(_) -> Void in
            sender.alpha = 1.0
        })
        delegate?.changeFontColor(color: sender.backgroundColor ?? UIColor.white)
    }
    
    @IBAction func hideAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
}
