//
//  HabitTableViewController.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 11/22/20.
//

import UIKit

class HabitTableViewController: UITableViewController{
    
    //Declare habit metrics so we can segue
    var habitName: String?
    var habitMoney: Double?
    var habitQuitDate: Date?
    
    //Declare an array of habit structures
    var habits = [Habit]()
    
    
    //Set override of tableview function so we can grab the values of the habit located at user specified indexPath
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Returns optional so we have some more work to do
            habitName = self.habits[indexPath.row].title
            habitMoney = self.habits[indexPath.row].dailyMoney
            habitQuitDate = self.habits[indexPath.row].quitDate
        
        print("\(String(describing: habitName))")
        print("\(String(describing: habitMoney))")
        print("\(String(describing: habitQuitDate))")
            
        }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    
    //Override table view for cellForRowAt, so habit struct variables go to correct cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "habitCellIdentifier")
        
        else{
            fatalError("Could not dequeue a cell")
        }
        
        let habit = habits[indexPath.row]
        cell.textLabel?.text = habit.title
        //Load our habit struct properties into this controllers variables
        
        return cell
    }
    
    //Override for viewDidLoad
    override func viewDidLoad() {
        
        //Add function to edit habits like a table
        navigationItem.leftBarButtonItem = editButtonItem
        
        super.viewDidLoad()
        
        //Set the title on this view controller
        self.navigationItem.title = "My Habits"
        
        if let savedHabits = Habit.loadHabits() {
            habits = savedHabits
        } else if let savedHabits = Habit.loadSampleHabits() {
            habits = savedHabits
        }
    }
    
    //Add delete option for habits
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Override function for delete button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            habits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Habit.saveHabits(habits)
        }
    }
    
    //Unwind segue from creating or canceling new quit date
    @IBAction func undwindToHabitList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! HabitViewController
        
        if let habit = sourceViewController.habit {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                habits[selectedIndexPath.row] = habit
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: habits.count, section: 0)
                
                habits.append(habit)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        //Save the list to disk
        Habit.saveHabits(habits)
        
    }
}
