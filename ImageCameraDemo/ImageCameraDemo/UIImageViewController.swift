//
//  UIImageViewController.swift
//  ImageCameraDemo
//
//  Created by user192371 on 3/8/21.
//

import UIKit

class UIImageViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var parentVC:Updateable?
    override func viewDidLoad() {
        super.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("back with an image")
        if let img = info[.originalImage] as? UIImage {
            parentVC?.update(obj: img)
        }
        picker.dismiss(animated: true, completion: nil)
    }

}
