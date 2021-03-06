//
//  ViewController.swift
//  Saving Data BayBeh
//
//  Created by leslie on 10/1/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var people:[PersonTableView] = []
    var people:[Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        people = try! PersistenceService.context.fetch(fetchRequest)
        
        self.tableView.reloadData()
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
        
        func inputAlert() {
            let alert = UIAlertController(title: "Please enter both name and age", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields?.first?.text
            let age = Int16((alert.textFields?.last?.text)!)
            
            if name != nil && name != "" {
                if age != nil {
                    print(name!, age!)
                    // Core Data - Array Model Saving
                    let person2 = Person(context: PersistenceService.context)
                    person2.name = name
                    person2.age = Int16(age!)
                    PersistenceService.saveContext()
                    
                    self.people.append(person2)
                    self.tableView.reloadData()
                    
                    // Local Data - Array Model Saving
//                    let person1 = PersonTableView.init(name: name, age: age)
//                    self.people.append(person1)
//                    self.tableView.reloadData()
                } else {
                    inputAlert()
                }
            } else {
                inputAlert()
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
        cell.detailTextLabel?.text = String(describing: self.people[indexPath.row].age)
        return cell
    }
}
