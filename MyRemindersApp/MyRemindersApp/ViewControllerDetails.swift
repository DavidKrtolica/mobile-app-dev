//
//  ViewControllerDetails.swift
//  MyRemindersApp
//
//  Created by user192371 on 3/29/21.
//

import UIKit

class ViewControllerDetails: UIViewController {
    
    @IBOutlet weak var titleEdit: UITextField!
    @IBOutlet weak var descriptionEdit: UITextView!
    @IBOutlet weak var dateString: UITextField!
    @IBOutlet weak var dateEdit: UIDatePicker!
    var currentIndex = 0
    var parent_view_controller:ViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleEdit.text = fS.reminders[currentIndex].title
        descriptionEdit.text = fS.reminders[currentIndex].description
        dateString.text = fS.reminders[currentIndex].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        dateEdit.date = dateFormatter.date(from: fS.reminders[currentIndex].date)!
    }
    
    @IBAction func updateReminder(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        fS.updateReminder(index: currentIndex, title: titleEdit.text!, description: descriptionEdit.text!, date: dateFormatter.string(from: dateEdit.date))
    }
    
}
