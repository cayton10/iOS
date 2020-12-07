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
    var dailyMoney: Float
    var dailyTime: Float //Not sure what data type to use here
    var quitDate: Date
    
    
    //Static method to load habits array with test data
    static func loadHabits() -> [Habit]? {
        return nil
    }
    
    
    //Static function
    static func loadSampleHabits() -> [Habit]? {
        let habit1 = Habit(title: "Alcohol", dailyMoney: 7.00, dailyTime: 0.66, quitDate: Date())
        let habit2 = Habit(title: "Doughnuts", dailyMoney: 5.00, dailyTime: 0.10, quitDate: Date())
        let habit3 = Habit(title: "Sleeping In", dailyMoney: 0.00, dailyTime: 0.33, quitDate: Date())
        
        return [habit1, habit2, habit3]
    }
    
}




