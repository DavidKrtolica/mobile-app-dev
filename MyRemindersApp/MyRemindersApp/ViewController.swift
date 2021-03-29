//
//  ViewController.swift
//  MyRemindersApp
//
//  Created by user192371 on 3/26/21.
//

import UIKit
import Firebase

let fS = FirebaseService()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Updateable{
    
    @IBOutlet weak var tableView: UITableView!
    private var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fS.parent = self
        fS.startListener()
        tableView.delegate = self
        tableView.dataSource = self
        fS.storageRef = fS.storage.reference()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fS.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = String(fS.reminders[indexPath.row].title)
        return cell
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        fS.deleteReminder(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    var editIndex = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIndex = indexPath.row
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewControllerDetails{
            dest.currentIndex = tableView.indexPathForSelectedRow?.row ?? 0
            dest.parent_view_controller = self
        }
    }
}

