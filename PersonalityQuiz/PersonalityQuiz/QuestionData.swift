//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Benjamin Paul Cayton on 9/17/20.
//  Copyright © 2020 Benjamin Paul Cayton. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", turkey = "🦃", frog = "🐸", monkey = "🐒"
    
    var definition: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .turkey:
            return "You like hanging out in bushes. Gobble gobble."
        case .frog:
            return "You live under bridges on lilly pads. Ribbit."
        case .monkey:
            return "Wild and crazy like a monkey, man."
        }
    }
}
