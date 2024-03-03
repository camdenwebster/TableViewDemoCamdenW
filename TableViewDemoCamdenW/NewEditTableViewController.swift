//
//  NewEditTableViewController.swift
//  TableViewDemoCamdenW
//
//  Created by Camden Webster on 2/27/24.
//

import UIKit

class NewEditTableViewController: UITableViewController, UITextFieldDelegate {
    
    let viewElements = [
    ["Title", "Notes"],
    ["Start date", "Due Date"],
    ["Size", "Difficulty", "Priority"],
    ["Category"]
    ]
    
    var toDo = ToDo(id: 1, title: "New Task", due: .now, size: 1, priority: 1, difficulty: 1, notes: "Test notes")
    
    let dateFormatter: DateFormatter = DateFormatter()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var sizeControl: UISegmentedControl!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyControl: UISegmentedControl!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var priorityControl: UISegmentedControl!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButtonMenu: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var newTaskButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        // Set up text fields
        titleTextField.becomeFirstResponder()
        titleTextField.text = toDo.title
        if titleTextField.text == nil {
            newTaskButton.isEnabled = false
        }
        titleTextField.delegate = self
        notesTextView.text = toDo.notes
        // Set up dates
        startDatePicker.date = toDo.start ?? .now
        dueDatePicker.date = toDo.due ?? .now
        // Set up segmented controls
        sizeControl.selectedSegmentIndex = toDo.size
        difficultyControl.selectedSegmentIndex = toDo.difficulty
        priorityControl.selectedSegmentIndex = toDo.priority
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewElements.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewElements[section].count
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method
    func textField(_ titleTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Determine the new text length
        let currentText = titleTextField.text ?? ""
        let newLength = currentText.count + string.count - range.length

        // Enable the button if the new text length is greater than 0, otherwise disable it
        newTaskButton.isEnabled = newLength > 0

        return true // Return true to allow the text change to happen
    }

    @IBAction func sizeControlTapped(_ sender: UISegmentedControl) {
        switch sizeControl.selectedSegmentIndex {
        case 0:
            toDo.size = 0
        case 1:
            toDo.size = 1
        case 2:
            toDo.size = 2
        default: toDo.size = 3
        }
        print("Set task size to \(toDo.size)")
    }
    
    @IBAction func startDatePicker(_ sender: UIDatePicker) {
        toDo.start = startDatePicker.date
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        print ("Setting start date to \(dateFormatter.string(from: toDo.start ?? .now))")
    }
    
    @IBAction func dueDatePicker(_ sender: UIDatePicker) {
        toDo.due = dueDatePicker.date
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        print ("Setting due date to \(dateFormatter.string(from: toDo.due ?? .now))")
    }
    
    @IBAction func difficultyControlTapped(_ sender: UISegmentedControl) {
        switch difficultyControl.selectedSegmentIndex {
        case 0:
            toDo.difficulty = 0
        case 1:
            toDo.difficulty = 1
        case 2:
            toDo.difficulty = 2
        default: toDo.difficulty = 1
        }
        print("Set task difficulty to \(toDo.difficulty)")
    }
    
    @IBAction func priorityControlTapped(_ sender: UISegmentedControl) {
        switch priorityControl.selectedSegmentIndex {
        case 0:
            toDo.priority = 0
        case 1:
            toDo.priority = 1
        case 2:
            toDo.priority = 2
        default: toDo.priority = 1
        }
        print("Set task priority to \(toDo.priority)")
    }
    
    @IBAction func categoryMenuTapped(_ sender: UIButton) {
        // TODO:
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let text = titleTextField.text, !text.isEmpty else {
            return
        }
        // If a value was entered we'll log it and close the sheet
        toDo.title = titleTextField.text
        print("Setting title to \(toDo.title ?? "New Task")")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        // Set up alert to be thrown if cancel is tapped
        let alert = UIAlertController(title: "Are you sure?", message: "Changes will be lost", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Delete Task", style: .destructive, handler: { action -> Void in
            self.dismiss(animated: true, completion: nil)        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action -> Void in
            //Just dismiss the action sheet
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
