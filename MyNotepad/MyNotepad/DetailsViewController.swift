//
//  DetailsViewController.swift
//  MyNotepad
//
//  Created by user192371 on 2/21/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var currentIndex = 0
    var parent_view_controller:ViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail VC called with currentIndex \(currentIndex)")
        textView.text = parent_view_controller?.items[currentIndex]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("leaving detailview")
        parent_view_controller?.items[currentIndex] = textView.text
        parent_view_controller?.tableView.reloadData()
    }
}
