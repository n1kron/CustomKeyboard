//
//  ViewController.swift
//  CustomKeyboards
//
//  Created by  Kostantin Zarubin on 09/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var keyboardView: KeyboardView!
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardView = KeyboardView.instanceFromNib(VC:self)
    }
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Consts.keyboards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCollectionViewCell", for: indexPath) as! KeyboardCollectionViewCell
        cell.imageView.image = UIImage(named: Consts.keyboards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 2.3, height: UIScreen.main.bounds.size.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn], animations: {
            self.alertView.alpha = 1.0
        }, completion: {(_) -> Void in
            UIView.animate(withDuration: 1, animations: {
                self.alertView.alpha = 0
            })
        })
        
        if let userDefaults = UserDefaults(suiteName: "group.com.emojies") {
            userDefaults.setImage(image: nil, forKey: "imageDefaults")
            userDefaults.set(indexPath.row, forKey: "Background")
            userDefaults.synchronize()
        }
    }
}





