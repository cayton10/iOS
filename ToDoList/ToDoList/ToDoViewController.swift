//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Benjamin Paul Cayton on 10/7/20.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    //Boolean for date picker hide show
    var isPickerHidden = true
    //optional model property to send back to TableViewController
    var todo: ToDo?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load editable (not edible) todo item
        //unwrap optional
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView?.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        //Set initial date to 24 hours ahead of new todo item
        dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }


    //Hide keyboard with return button
    @IBAction func returnPressed(_ sender: UITextField) {
        //Resigns the testfield as first responder
        titleTextField.resignFirstResponder()
    }
    
    //Is complete button function
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    
    //New todo control outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    //Save button outlet
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    //Func ToDo struct type method for updating date label
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    //Function to hide/show date picker
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let normalCellHeight = CGFloat(44)
            let largeCellHeight = CGFloat(200)
            
            switch indexPath {
            case [1, 0]:
                return isPickerHidden ? normalCellHeight : largeCellHeight
            case [2, 0]:
                return largeCellHeight
            default:
                return normalCellHeight
            }
        }
    
    //Respond to user touch to show picker
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath {
            case [1, 0]:
                isPickerHidden = !isPickerHidden
                
                dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
                
                tableView.beginUpdates()
                tableView.endUpdates()
            default:
                break
            }
        }
    
    //Save user's supplied todo information, prepare segue, lick stamp... send :)
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        //Make sure to designate notes as an optional
        let notes = notesTextView?.text
        //Load all the values into the singular ToDo type object
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }

    

}


