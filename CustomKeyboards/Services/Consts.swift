//
//  Consts.swift
//  CustomKeyboards
//
//  Created by  Kostantin Zarubin on 18/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class Consts {
    
    static let isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    static let fonts = ["HelveticaNeue-Bold", "HelveticaNeue-Italic"]
    
    static let numbersKeys = ["1", "2", "3","4", "5", "6", "7", "8", "9", "0"]
    static let firstRowSymbols = ["@", "/", ":",";", "(", ")", "$", "&", "-"]
    static let secondRowSymbols = [".", ",", "?","!", "*", "+", "="]
    static let firstRowChars = ["q", "w", "e","r", "t", "y", "u", "i", "o", "p"]
    static let upperCaseFirstRowChars = ["Q", "W", "E","R", "T", "Y", "U", "I", "O", "P"]
    static let secondRowChars = ["a", "s", "d","f", "g", "h", "j", "k", "l"]
    static let upperCaseSecondRowChars = ["A", "S", "D","F", "G", "H", "J", "K", "L"]
    static let thirdRowChars = ["z", "x", "c","v", "b", "n", "m"]
    static let upperCaseThirdRowChars = ["Z", "X", "C","V", "B", "N", "M"]
    
    static let fourthSymbols = ["[", "]", "{","}", "#", "%", "^", "_", "/", "|"]
    static let fifthSymbols = ["'", "<", ">","☮︎", "∙", "♤", "♧", "♡", "♢"]
    
    static let keyboards = ["keyboard0", "keyboard1", "keyboard2","keyboard3", "keyboard4", "keyboard5", "keyboard6", "keyboard7", "keyboard8", "keyboard9"]
}
