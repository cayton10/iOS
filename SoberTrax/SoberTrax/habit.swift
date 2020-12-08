//
//  habit.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 12/6/20.
//

import Foundation

//Create a struct of habit for our data model

struct Habit{
    
    var title: String
    var dailyMoney: Double
    var quitDate: Date
    
    
    //Date formatters
    static let quitDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    //Static method to load habits array with test data
    static func loadHabits() -> [Habit]? {
        return nil
    }
    
    
    //Static function
    static func loadSampleHabits() -> [Habit]? {
        let habit1 = Habit(title: "Alcohol", dailyMoney: 7.00, quitDate: Date())
        let habit2 = Habit(title: "Doughnuts", dailyMoney: 5.00, quitDate: Date())
        let habit3 = Habit(title: "Sleeping In", dailyMoney: 0.00, quitDate: Date())
        
        return [habit1, habit2, habit3]
    }
    
}




