//
//  game.swift
//  Apple PIe
//
//  Created by Benjamin Paul Cayton on 9/7/20.
//  Copyright © 2020 Benjamin Paul Cayton. All rights reserved.
//

import Foundation

struct Game
{
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    //Add mutating function for player guess
    mutating func playerGuessed(letter: Character)
    {
        guessedLetters.append(letter)
        if !word.contains(letter)
        {
            incorrectMovesRemaining -= 1
        }
    }
    
    //Formatting word
    var formattedWord: String
    {
        var guessedWord = ""
        for letter in word
        {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
