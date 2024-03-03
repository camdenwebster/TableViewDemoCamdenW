//
//  TasksViewController.swift
//  TabBarPickersDemoCamdenW
//
//  Created by Camden Webster on 2/20/24.
//

import UIKit

class TasksViewController: UITableViewController {
    
    // Default task to be added at app launch
    var todos = [ToDo]()
    var firstToDo = ToDo(id: 1, title: "New Task", due: .now, size: 1, priority: 1, difficulty: 1, notes: "Test notes")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        // Do any additional setup after loading the view.
        todos.append(firstToDo)
        for todo in todos {
            guard todo.title != nil else {
                return
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        cell.textLabel?.text = "\(todos[indexPath.row].title ?? "New Task") \(todos[indexPath.row].id)"
        return cell
    }
}
