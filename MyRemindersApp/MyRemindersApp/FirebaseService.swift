//
//  FirebaseService.swift
//  MyRemindersApp
//
//  Created by user192371 on 3/26/21.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseService {
    
    var db = Firestore.firestore()
    var storage = Storage.storage()
    var storageRef:StorageReference?
    var reminders = [Reminder]()
    var parent:Updateable?
    
    func addReminder(title:String, description:String, date:String) {
        let doc = db.collection("reminders").document()
        var data = [String:Any]()
        data["title"] = title
        data["description"] = description
        data["date"] = date
        doc.setData(data)
    }
    
    func deleteReminder(index:Int) {
        if index < reminders.count {
            let docID = reminders[index].id
            db.collection("reminders").document(docID).delete(){ err in
                if let e = err {
                    print("error deleting \(docID) \(e)")
                }else {
                    print("ok deleting \(docID)")
                }
            }
            reminders.remove(at: index)
        }
    }
    
    func updateReminder(index:Int, title:String, description:String, date:String) {
        if index < reminders.count {
            let docID = reminders[index].id
            let doc = db.collection("reminders").document(docID)
            var data = [String:Any]()
            data["title"] = title
            data["description"] = description
            data["date"] = date
            doc.setData(data)
        }
    }
    
    func startListener() {
        db.collection("reminders").addSnapshotListener { (snap, error) in
            if let e = error {
                print("error fetching data \(e)")
            } else {
                if let s = snap {
                    self.reminders.removeAll()
                    for doc in s.documents {
                        if let title = doc.data()["title"] as? String, let description = doc.data()["description"] as? String, let date = doc.data()["date"] as? String{
                            let reminder = Reminder(id:doc.documentID, title: title, description: description, date: date)
                            self.reminders.append(reminder)
                        }
                    }
                    self.parent?.update()
                }
            }
        }
    }
    
}
