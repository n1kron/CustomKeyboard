//
//  CustomizationViewController.swift
//  CustomKeyboards
//
//  Created by  Kostantin Zarubin on 20/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Photos
import LGButton

class CustomizationViewController: UIViewController {
    
    @IBOutlet var colorView: ColorView!
    @IBOutlet weak var fontButton: LGButton!
    
    private var imagePicker = UIImagePickerController()
    weak var keyboardView: KeyboardView!
    var fontCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.delegate = self
        
        keyboardView = KeyboardView.instanceFromNib(VC:self)
        keyboardView.isUserInteractionEnabled = false
        keyboardView.clipsToBounds = true
        keyboardView.layer.borderWidth = 1.0
        keyboardView.layer.borderColor = UIColor.blue.cgColor
        self.view.addSubview(keyboardView)
        
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            keyboardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            keyboardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: Consts.isIpad ? UIScreen.main.bounds.size.height / 3.5 : UIScreen.main.bounds.size.height / 3)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        keyboardView.awakeFromNib()
    }
    
    func pickBackgroundImage() {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func changeFont(_ sender: Any) {
        fontCount += 1
        if fontCount == 2 {
            fontCount = 0
        }
        keyboardView.font = UIFont(name: Consts.fonts[fontCount], size: 20)
        keyboardView.awakeFromNib()
    }
    
    @IBAction func fontColorAction(_ sender: Any) {
        fontButton.isEnabled = false
        self.view.addSubview(colorView)
        colorView.animShow()
    }
}

extension CustomizationViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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

extension CustomizationViewController: ColorDelegate {
    func changeFontColor(color: UIColor) {
        keyboardView.keyboardButtons.forEach({$0.setTitleColor(color, for: .normal)})
        if let userDefaults = UserDefaults(suiteName: "group.com.emojies") {
            userDefaults.set(color, forKey: "Color")
        }
    }
    
    func fontButtonEnable() {
        fontButton.isEnabled = true
    }
}
