//
//  HabitViewController.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 12/7/20.
//

import UIKit

class HabitViewController: UITableViewController {
    
    //View did load
    override func viewDidLoad(){
        super.viewDidLoad()
        updateSaveButtonState()
    }
    
    //Connect all control and view outlets
    @IBOutlet weak var habitTextField: UITextField!
    @IBOutlet weak var moneySpentTextField: UITextField!
    @IBOutlet weak var timeSpentPicker: UIDatePicker!
    @IBOutlet weak var quitDateLabel: UILabel!
    @IBOutlet weak var dateQuitPicker: UIDatePicker!
    
    //Disable the save button unless information is entered for all
    //habit properties
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Disable helper
    func updateSaveButtonState() {
        let text = habitTextField.text ?? ""
        let money = moneySpentTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        saveButton.isEnabled = !money.isEmpty
    }
    
    //Update save button on text change for habit name
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    //Update save button on text change for money spent
    @IBAction func moneyEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    /*
     Dismiss keyboard using return key for both text fields
     */
    //Link returnPressed function to both text fields
    @IBAction func returnPressed(_ sender: UITextField) {
        habitTextField.resignFirstResponder()
        moneySpentTextField.resignFirstResponder()
    }

    
    
}
