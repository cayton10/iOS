//
//  HabitViewController.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 12/7/20.
//

import UIKit

class HabitViewController: UITableViewController, UITextFieldDelegate {
    
    
    //Declare our model habit variable
    var habit: Habit?
    
    //Hide the date picker for screen real estate
    var isPickerHidden = true
    
    //View did load
    override func viewDidLoad(){
        super.viewDidLoad()
        updateQuitDateLabel(date: dateQuitPicker.date)
        updateSaveButtonState()
        
        moneySpentTextField.delegate = self
        
        moneySpentTextField.placeholder = updateAmount()
    }
    
    //Connect all control and view outlets
    @IBOutlet weak var habitTextField: UITextField!
    @IBOutlet weak var moneySpentTextField: UITextField!
    
    //All logic behind currency text field
    var amt: Int = 0
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
    }
    
    //Set appropriate date for quitDateLabel
    func updateQuitDateLabel(date: Date) {
        quitDateLabel.text = Habit.quitDateFormatter.string(from: date)
    }

    @IBAction func quitDatePickerChanged(_ sender: UIDatePicker) {
        updateQuitDateLabel(date: dateQuitPicker.date)
    }
    
    //Hide the quit date picker until it's clicked
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath){
        case[2, 0]: //Quit date picker spent cell
            return isPickerHidden ? normalCellHeight : largeCellHeight //Ternary
            
        default: return normalCellHeight
        }
    }
    
    //Function to register tapping response on quit date cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        moneySpentTextField.resignFirstResponder()
        
        switch (indexPath) {
        case [2,0]:
            isPickerHidden = !isPickerHidden
            
            quitDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }
    
    //Save user's supplied todo information, prepare segue, lick stamp... send :)
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let name = habitTextField.text!
        let quitDate = dateQuitPicker.date
        if let money = Double(moneySpentTextField.text!){
            //Load all the values into the singular ToDo type object
            habit = Habit(title: name, dailyMoney: money, quitDate: quitDate)
        } else {
            print("Not a valid number: \(moneySpentTextField.text!)")
        }
        
        //Make sure to designate notes as an optional

        
    }
    
    
    /***
        Really helpful video I found for overriding text fields for the purposes of currency input. When the user inputs information,
        the string supplied to the text field is passed as a parameter to the textField function below. The string, 'digit' is explicity cast
        as an integer and computed into decimal format, so we can pass it to the updateAmount function. Amount is processed as
        a double value, then recast back to string for output to the text field in currency / double format. This eliminates the need for
        users to type commas, decimals, and currency symbols when inputting their data.
     */
    
    //Update the text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Conditional
        if let digit = Int(string) {
            amt = amt * 10 + digit
            
            //This is the point at which our 'int' gets a little too big, and the function will crash
            /*Fix for exceeding integer size*/
            if amt > 1_000_000_000_00 {
                
                let alert = UIAlertController(title: "I hope you don't spend that much DAILY on bad habits. Try a smaller value", message: nil, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Enter Spending", style: UIAlertAction.Style.default, handler: nil))
                
                present(alert, animated: true, completion: nil) //Present the actual alert which we have defined above
                
                moneySpentTextField.text = "" //Reset the text field
                
                amt = 0 //Reset our amount for processing in our functions
            }
            moneySpentTextField.text = updateAmount()
        }
        else
        {
            //Proceed as normal
            moneySpentTextField.text = updateAmount()
        }
        
        if string == "" {
            amt = amt / 10
            //Ternary control
            moneySpentTextField.text = amt == 0 ? "" : updateAmount()
        }
        
        return false
    }
    
    //Update amount function for moneySpentTextField placeholder
    func updateAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        
        let amount = Double(amt / 100) + Double(amt % 100) / 100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /**
 *End help*/
    
    
}
