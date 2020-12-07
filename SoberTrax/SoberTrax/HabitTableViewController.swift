//
//  HabitTableViewController.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 12/6/20.
//

import UIKit

class HabitTableViewController: UITableViewController{
    
    
    //Declare an array of habit structures
    var habits = [Habit]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    
    //Override table view for cellForRowAt, so we know which cell we're dealing w/ on click
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "habitCellIdentifier")
        
        else{
            fatalError("Could not dequeue a cell")
        }
        
        let habit = habits[indexPath.row]
        cell.textLabel?.text = habit.title
        return cell
    }
    
    //Override for viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the title on this view controller
        self.navigationItem.title = "My Habits"
        
        if let savedHabits = Habit.loadHabits() {
            habits = savedHabits
        } else if let savedHabits = Habit.loadSampleHabits() {
            habits = savedHabits
        }
    }
}
