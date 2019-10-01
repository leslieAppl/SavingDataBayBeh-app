//
//  ViewController.swift
//  Saving Data BayBeh
//
//  Created by leslie on 10/1/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people:[PersonTableView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func onPlusBtn() {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields?.first?.text
            let age = Int16((alert.textFields?.last?.text)!)
            
            if name != nil, age != nil {
                print(name!, age!)
                let person = PersonTableView.init(name: name, age: age)
                self.people.append(person)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Please enter both name and age", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                    
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = self.people[indexPath.row].name
        cell.detailTextLabel?.text = String(describing: self.people[indexPath.row].age!)
        return cell
    }
}
