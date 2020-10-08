//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Benjamin Paul Cayton on 10/7/20.
//

import UIKit


class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    

    
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell
        else {
            fatalError("Could not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        cell.delegate = self
        
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
            ToDo.saveToDos(todos)//Persist data after deletion
        }
    }
    
    //Unwind segue for new todo item finish and cancel?
    @IBAction func undwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as!
        ToDoViewController
        
        //Unwrap our ToDo
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //find an appropriate place to put the info
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                //add todo to array
                todos.append(todo)
                //Populate information
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
    
    //Send current todo item details to static table view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetails" {
                let todoViewController = segue.destination as! ToDoViewController
                let indexPath = tableView.indexPathForSelectedRow!
                let selectedTodo = todos[indexPath.row]
                
                todoViewController.todo = selectedTodo
            }
        }
    
    
    //Delegate protocol
    func checkMarkTapped(_ sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

    }
    
    func completeButtonTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
}


