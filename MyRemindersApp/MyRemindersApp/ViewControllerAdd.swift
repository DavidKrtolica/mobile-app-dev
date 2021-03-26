//
//  ViewControllerAdd.swift
//  MyRemindersApp
//
//  Created by user192371 on 3/26/21.
//

import UIKit

class ViewControllerAdd: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var dateInput: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveReminder(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        fS.addReminder(title: titleInput.text!, description: descriptionInput.text!, date: dateFormatter.string(from: dateInput.date))
    }
    
}
