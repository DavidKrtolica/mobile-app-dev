//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by user192371 on 2/22/21.
//

import UIKit
import Firebase

let fS = FirebaseService()

class ViewController: UIViewController, Updateable, UpdateableImg, UITableViewDelegate, UITableViewDataSource {
    
    func update(obj: NSObject?) {
        if let img = obj as? UIImage {
            myimage.image = img
        }
    }
        
    @IBOutlet var myimage: UIImageView!
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var tableView: UITableView!
    private var db = Firestore.firestore()
    var myImagePicker = UIImageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fS.parent = self
        fS.startListener()
        tableView.delegate = self
        tableView.dataSource = self
        fS.storageRef = fS.storage.reference()
        //UPLOADING IMAGES
        if let img = UIImage(named: "cow.jpg") {
            fS.uploadImg(image: img)
            print("ok image")
        } else {
            print("bad image")
        }
        //DOWNLOADING IMAGES
        // Create a reference to the file you want to download
        let cowRef = fS.storageRef!.child("cow.jpg")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        cowRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("An error occurred \(error)")
          } else {
            self.myimage.image = UIImage(data: data!)
            print("Downloaded image!")
          }
        }
        myImagePicker.parentVC = self

    }
    
    //FUNCTION FOR SAVING DATA ONCE SAVE BUTTON PRESSED
    @IBAction func savePressed(_ sender: UIButton) {
        print("press save")
         if let txt = textBox.text {
            fS.addNote(text: txt)
         }
    }
    
    @IBAction func choosePhoto(_ sender: UIButton) {
        myImagePicker.sourceType = .photoLibrary
        present(myImagePicker, animated: true)
    }
    
    @IBAction func savePhoto(_ sender: UIButton) {
        if let data = myimage.image!.jpegData(compressionQuality: 1.0) {
            let imageRef = fS.storageRef?.child("\(String(describing: myimage.image?.description)).jpg")
            imageRef?.putData(data, metadata: nil, completion: { (metadata, error) in
                if let e = error {
                    print("error uploading image \(e)")
                }else {
                    print("OK uploading image")
                }
            })
        }
        print("Saving successful!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fS.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = String(fS.notes[indexPath.row].text.prefix(15))
        return cell
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("edit called \(indexPath.row)")
        fS.deleteNote(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        // this requires, that the underlying datasource ALSO gets updated.
    }
    
    var editIndex = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked on row \(indexPath.row)")
        editIndex = indexPath.row
        //textBox.text = fS.notes[editIndex].text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewControllerDetails{
            dest.currentIndex = tableView.indexPathForSelectedRow?.row ?? 0 // if-else > 0
            dest.parent_view_controller = self
        }
        print("prepare is called \(segue.destination.description)")
    }
    
}
