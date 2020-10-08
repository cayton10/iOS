//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Benjamin Paul Cayton on 10/7/20.
//

import UIKit


class ToDoTableViewController: UITableViewController {
    
    //Create array of todo list items
    var todos = [ToDo]()
    
    //View did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Unwrap our optional
        if let savedToDos = ToDo.loadToDos() {//If todos on disk are present, load them
            todos = savedToDos
        } else if let savedToDos = ToDo.loadSampleToDos() { //This section of code is incorrect in book
            todos = savedToDos//Load sample list if no items have been saved
        }
        
        //Editing code implementation for entire table
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //Override number of rows in section function from UITableViewController
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    //Override cell for row at index path function from UITableViewController
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier")
        else {
            fatalError("Could not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
    
    //Override for 'swipe to delete' function
    //Inclusion of this overridden function lets us display the red delete button and swipe to delete... pretty nifty
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Overridden function to use delete button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)//Will remove todo item at specified index from array
            tableView.deleteRows(at: [indexPath], with: .fade)//Animation for deletion and removal from UI cell
        }
    }
    
    //Unwind segue for new todo item finish and cancel?
    @IBAction func undwindToToDoList(segue: UIStoryboardSegue) {
        
    }
}
