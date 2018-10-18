//
//  ViewController.swift
//  CustomKeyboards
//
//  Created by  Kostantin Zarubin on 09/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Photos

class MainViewController: UIViewController {
    
    weak var keyboardView: KeyboardView!
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardView = KeyboardView.instanceFromNib(VC:self)
        keyboardView.isUserInteractionEnabled = false
        self.view.addSubview(keyboardView)
        
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            keyboardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            keyboardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: 216)
            ])
        if let userDefaults = UserDefaults(suiteName: "group.com.emojies") {
            keyboardView.backgroundNumber  = userDefaults.integer(forKey: "Background")
        }
    }
    
    func pickBackgroundImage() {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum;
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func fontColorAction(_ sender: Any) {
        
    }
    
    @IBAction func addCustomBackAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization({[weak self] status in
                    if status == .authorized {
                        self?.pickBackgroundImage()
                    }
                })
            } else if status == .authorized {
                pickBackgroundImage()
            } else if status == .denied {
                  print("deny")
            }
        }
    }
    
    @IBAction func themeChooseAction(_ sender: Any) {
        keyboardView.userBackground = nil
        keyboardView.backgroundNumber += 1
        if keyboardView.backgroundNumber == 10 {
            keyboardView.backgroundNumber = 0
        }
        if let userDefaults = UserDefaults(suiteName: "group.com.emojies") {
            userDefaults.setImage(image: nil, forKey: "imageDefaults")
            userDefaults.set(keyboardView.backgroundNumber, forKey: "Background")
            userDefaults.synchronize()
        }
        keyboardView.awakeFromNib()
    }
}

extension MainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        keyboardView.userBackground = selectedImage
        if let userDefaults = UserDefaults(suiteName: "group.com.emojies") {
            userDefaults.setImage(image: keyboardView.userBackground, forKey: "imageDefaults")
            keyboardView.awakeFromNib()
            userDefaults.synchronize()
        }
        dismiss(animated: true, completion: nil)
    }
}

