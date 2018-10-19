//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by  Kostantin Zarubin on 09/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    weak var delegateKeyboardView: KeyboardView!
    var capsLockOn = true
    var numbersOn = false
    var secondNumbersOn = false
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        delegateKeyboardView = KeyboardView.instanceFromNib(VC:self)
        self.view.addSubview(delegateKeyboardView)
        
        NSLayoutConstraint.activate([
            delegateKeyboardView.leftAnchor.constraint(equalTo: (inputView?.leftAnchor)!),
            delegateKeyboardView.topAnchor.constraint(equalTo: (inputView?.topAnchor)!),
            delegateKeyboardView.rightAnchor.constraint(equalTo: (inputView?.rightAnchor)!),
            delegateKeyboardView.bottomAnchor.constraint(equalTo: (inputView?.bottomAnchor)!),
            delegateKeyboardView.heightAnchor.constraint(equalToConstant: Consts.isIpad ? UIScreen.main.bounds.size.height / 3.5 : UIScreen.main.bounds.size.height / 3)
            ])
        delegateKeyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        delegateKeyboardView.awakeFromNib()
    }
    
    @IBAction func spacebarAction(_ sender: Any) {
        textDocumentProxy.insertText(" ")
    }
    
    @IBAction func backspaceAction(_ sender: Any) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        button.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        if !numbersOn {
            capsLockOn = !capsLockOn
            changeCaps(containerView: delegateKeyboardView.row1)
            changeCaps(containerView: delegateKeyboardView.row2)
            changeCaps(containerView: delegateKeyboardView.row3)
            changeCaps(containerView: delegateKeyboardView.row4)
        } else {
            changeText(containerView: delegateKeyboardView.row1, numPad: Consts.fourthSymbols ,chars: Consts.numbersKeys, charsUpper: Consts.numbersKeys)
            changeText(containerView: delegateKeyboardView.row2, numPad: Consts.fifthSymbols ,chars: Consts.firstRowSymbols, charsUpper: Consts.firstRowSymbols)
            secondNumbersOn = !secondNumbersOn
        }
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        numbersOn = !numbersOn
        if button.titleLabel!.text == "123" {
            delegateKeyboardView.capsLockButton.setImage(nil, for: .normal)
            delegateKeyboardView.capsLockButton.setTitle("#+=", for: .normal)
            button.setTitle("АБВ", for: .normal)
        } else if button.titleLabel!.text == "АБВ" {
            delegateKeyboardView.capsLockButton.setImage(UIImage(named: "capsLock"), for: .normal)
            delegateKeyboardView.capsLockButton.setTitle(" ", for: .normal)
            secondNumbersOn = false
            button.setTitle("123", for: .normal)
        }
        
        changeText(containerView: delegateKeyboardView.row1, numPad: Consts.numbersKeys ,chars: Consts.firstRowChars, charsUpper: Consts.upperCaseFirstRowChars)
        changeText(containerView: delegateKeyboardView.row2, numPad: Consts.firstRowSymbols ,chars: Consts.secondRowChars, charsUpper: Consts.upperCaseSecondRowChars)
        changeText(containerView: delegateKeyboardView.row3, numPad: Consts.secondRowSymbols ,chars: Consts.thirdRowChars, charsUpper: Consts.upperCaseThirdRowChars)
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    func changeText(containerView: UIView, numPad: [String] ,chars: [String], charsUpper: [String]) {
        var index = 0
        
        var filter = containerView.subviews
        filter.removeFirst()
        filter.removeLast()
        
        let subviews = containerView == delegateKeyboardView.row3 ? filter : containerView.subviews
        
        for view in subviews {
            if let button = view as? UIButton {
                if numbersOn {
                    if !secondNumbersOn {
                        button.setTitle("\(numPad[index])", for: .normal)
                        index += 1
                    } else {
                        button.setTitle("\(chars[index])", for: .normal)
                        index += 1
                    }
                } else {
                    if !capsLockOn {
                        button.setTitle("\(chars[index])", for: .normal)
                        index += 1
                    } else {
                        button.setTitle("\(charsUpper[index])", for: .normal)
                        index += 1
                    }
                }
            }
        }
    }
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                if let buttonTitle = button.titleLabel?.text {
                    if capsLockOn {
                        let text = buttonTitle.uppercased()
                        button.setTitle("\(text)", for: .normal)
                    } else {
                        let text = buttonTitle.lowercased()
                        button.setTitle("\(text)", for: .normal)
                    }
                }
            }
        }
    }
}
