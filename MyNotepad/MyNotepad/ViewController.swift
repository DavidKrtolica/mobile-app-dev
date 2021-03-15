//
//  ViewController.swift
//  MyNotepad
//
//  Created by user192371 on 2/21/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var items = ["Anne", "Ole", "Trine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create content for one row at a time
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        let l = String(items[indexPath.row].prefix(15))
        cell.textLabel?.text = l
        // exercise: Limit text to only, say 15 characters.
        // Back at 15.25
        return cell
    }
        
    @IBAction func addRowPressed(_ sender: UIButton) {
        items.append("Hello")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked \(indexPath.row)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailsViewController{
            dest.currentIndex = tableView.indexPathForSelectedRow?.row ?? 0 // if-else > 0
            dest.parent_view_controller = self
        }
        print("prepare is called \(segue.destination.description)")
    }
}
