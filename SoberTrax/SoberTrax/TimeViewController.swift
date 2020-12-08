//
//  TimeViewController.swift
//  SoberTrax
//
//  Created by Benjamin Paul Cayton on 12/7/20.
//

import UIKit

class TimeViewController: UITableViewController {
    
    
    //Place all of our progress bars so we can apply logic
    
    //Set up timer variable
    var timer: Timer!
    
    @IBOutlet weak var secondsProgressView: UIProgressView!
    
    var counter: Int = 0
    var total: Int = 1
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: <#T##(Timer) -> Void#>)

        
        
        
            
            
        }
    }
    

    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


