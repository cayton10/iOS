//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Benjamin Paul Cayton on 10/7/20.
//

import UIKit

class ToDoViewController: UITableViewController {
    

    
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
    


}


