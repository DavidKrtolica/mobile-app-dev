//
//  ViewController.swift
//  ImageCameraDemo
//
//  Created by user192371 on 3/8/21.
//

import UIKit

class ViewController: UIViewController, Updateable {

    @IBOutlet weak var myimage: UIImageView!
    var myImagePicker = UIImageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myImagePicker.parentVC = self
    }

    //PICK IMG FROM PHOTO LIBRARY
    @IBAction func libraryButton(_ sender: UIButton) {
        myImagePicker.sourceType = .photoLibrary
        present(myImagePicker, animated: true)
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        myImagePicker.sourceType = .camera
        present(myImagePicker, animated: true)
    }
    
    @IBAction func drawButton(_ sender: UIButton) {
        
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(myimage.image!, nil, nil, nil)
        print("Saving successful!")
    }
    
    func update(obj:NSObject?) {
        if let img = obj as? UIImage {
            myimage.image = img
        }
    }
}

