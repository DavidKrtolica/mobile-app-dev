//
//  FirebaseService.swift
//  FirebaseDemo
//
//  Created by user192371 on 3/1/21.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseService {
    
    var db = Firestore.firestore()
    var storage = Storage.storage()
    var storageRef:StorageReference?
    var notes = [Note]()
    var parent:Updateable?
    
    func addNote(text:String) {
        print("addNote called with \(text)")
        if (text.count > 0) {
            let doc = db.collection("notes").document() // NEW DOCUMENT
            var data = [String:String]() //CREATE A NEW EMPTY MAP
            data["text"] = text //ASSIGNS THE TEXT FROM TEXTBOX TO DATA SENT
            data["imgRef"] = ""
            doc.setData(data) //WILL SAVE THE DATA TO FIREBASE
        }
    }
    
    func deleteNote(index:Int) {
        if index < notes.count {
            let docID = notes[index].id
            db.collection("notes").document(docID).delete(){ err in
                if let e = err {
                    print("error deleting \(docID) \(e)")
                }else {
                    print("ok deleting \(docID)")
                }
            }
            notes.remove(at: index) // will remove the item to be deleted
        }
    }
    
    func updateNote(index:Int, text:String) {
        if index < notes.count {
            let docID = notes[index].id
            let doc = db.collection("notes").document(docID)
            var data = [String:String]()
            data["text"] = text
            data["imgRef"] = String(fS.notes[index].imgRef)
            doc.setData(data)
        }
    }
    
    func uploadImg(image:UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let imageRef = storageRef?.child("cow.jpg")
            imageRef?.putData(data, metadata: nil, completion: { (metadata, error) in
                if let e = error {
                    print("error uploading image \(e)")
                }else {
                    print("OK uploading image")
                }
            })
        }
    }
    
    func startListener() {
        db.collection("notes").addSnapshotListener { (snap, error) in
            if let e = error {
                print("error fetching data \(e)")
            } else {
                if let s = snap {
                    self.notes.removeAll()
                    for doc in s.documents {
                        if let txt = doc.data()["text"] as? String, let ref = doc.data()["imgRef"] as? String {
                            print(txt)
                            print(ref)
                            print(doc.documentID)
                            let note = Note(id:doc.documentID, text: txt, imgRef: ref)
                            self.notes.append(note)
                        }
                    }
                    self.parent?.update()
                }
            }
        }
    }
    
}
