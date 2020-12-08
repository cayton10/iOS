//
//  habit.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 11/22/20.
//

import Foundation

//Create a struct of habit for our data model

struct Habit: Codable {
    
    var title: String
    var dailyMoney: Double?
    var quitDate: Date
    
    
    //Date formatter object
    static let quitDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    
    //Load actual saved information
    static func loadHabits() -> [Habit]? {
        //Guard let statement loads all information in ArchiveURL related to Habits
        guard let codedHabits = try? Data(contentsOf: ArchiveURL)
        else {return nil}
        
        //Try statement decodes all returned information, if in format of Habits then, cool
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Habit>.self, from: codedHabits)
    }
    
    //Static function to save data to disk
    static func saveHabits(_ habits: [Habit]) {
        //Declare a constant of propertyListEncoder object type
        let propertyListEncoder = PropertyListEncoder()
        //Encode the habits array for storage
        let codedHabits = try? propertyListEncoder.encode(habits)
        try? codedHabits?.write(to: ArchiveURL, options: .noFileProtection)//Write file
    }
    
    
    //Static function to load data from disk
    static func loadSampleHabits() -> [Habit]? {
        let habit1 = Habit(title: "Biting Nails", dailyMoney: 0.00, quitDate: Date())
        let habit2 = Habit(title: "Doughnuts", dailyMoney: 5.00, quitDate: Date())
        
        return [habit1, habit2]
    }
    
    
    //For data persistence and directory info
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("habits").appendingPathExtension("plist")
    
}




