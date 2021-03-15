//
//  ViewController.swift
//  SavingNotes
//
//  Created by user192371 on 2/21/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = UserDefaults.standard.object(forKey: "text") as? String
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        UserDefaults.standard.set(textView.text, forKey: "text")
    }
    
}
