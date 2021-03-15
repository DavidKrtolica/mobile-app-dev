//
//  ViewControllerDetails.swift
//  FirebaseDemo
//
//  Created by user192371 on 3/12/21.
//

import UIKit

class ViewControllerDetails: UIViewController, UpdateableImg {
    
    func update(obj: NSObject?) {
        if let img = obj as? UIImage {
            detailsImage.image = img
        }
    }

    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var textBox: UITextView!
    var currentIndex = 0
    var parent_view_controller:ViewController? = nil
    var myImagePicker = UIImageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail VC called with currentIndex \(currentIndex)")
        textBox.text = String(fS.notes[currentIndex].text)
        let imgPath = String(fS.notes[currentIndex].imgRef)
        let imgRef = fS.storageRef!.child(imgPath)
        imgRef.getData(maxSize: 1 * 20480 * 20480) { data, error in
          if let error = error {
            print("An error occurred \(error)")
          } else {
            self.detailsImage.image = UIImage(data: data!)
            print("Downloaded image!")
          }
        }
        myImagePicker.parentVC = self
    }
    
    @IBAction func updateNote(_ sender: UIButton) {
        print("press update")
        if let txt = textBox.text {
            fS.updateNote(index: parent_view_controller!.editIndex, text: txt)
        }
    }
    
    @IBAction func photoLibrary(_ sender: UIButton) {
        myImagePicker.sourceType = .photoLibrary
        present(myImagePicker, animated: true)
    }
    
    @IBAction func saveToNote(_ sender: UIButton) {
        let docID = fS.notes[parent_view_controller!.editIndex].id
        let doc = fS.db.collection("notes").document(docID)
        var data = [String:String]()
        let imageRef = fS.storageRef?.child("\(String(describing: detailsImage.image?.description)).jpg")
        data["text"] = String(fS.notes[currentIndex].text)
        data["imgRef"] = imageRef?.name
        doc.setData(data)
        imageRef?.putData(detailsImage.image!.jpegData(compressionQuality: 1.0)!, metadata: nil, completion: { (metadata, error) in
            if let e = error {
                print("error uploading image \(e)")
            }else {
                print("OK uploading image")
            }
        })
    }
}
