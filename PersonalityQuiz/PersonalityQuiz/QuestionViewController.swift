//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Benjamin Paul Cayton on 9/17/20.
//  Copyright © 2020 Benjamin Paul Cayton. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    

    
    var questions: [Question] = [
        Question(text: "Which food do you like most?",
                 type: .single,
                 answers:[
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Corn", type: .turkey),
                    Answer(text: "Bugs", type: .frog),
                    Answer(text: "Bananas", type: .monkey)
        ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers:[
                    Answer(text: "Eating", type: .dog),
                    Answer(text: "Sleeping", type: .turkey),
                    Answer(text: "Swimming", type: .frog),
                    Answer(text: "Grooming", type: .monkey)
        ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers:[
                    Answer(text: "I dislike them", type: .turkey),
                    Answer(text: "I get a little nervous", type: .monkey),
                    Answer(text: "I barely notice them", type: .frog),
                    Answer(text: "I love them", type: .dog)
        ]),
        
    ]
    
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            
            updateRangedStack(using: currentAnswers)
        }
        
    }
    
    //Update single
    func updateSingleStack(using answers: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
