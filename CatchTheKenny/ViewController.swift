//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Kadir Ferik on 22.02.2024.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var kennyTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kennyView1: UIImageView!
    @IBOutlet weak var kennyView2: UIImageView!
    @IBOutlet weak var kennyView3: UIImageView!
    @IBOutlet weak var kennyView4: UIImageView!
    @IBOutlet weak var kennyView5: UIImageView!
    @IBOutlet weak var kennyView6: UIImageView!
    @IBOutlet weak var kennyView7: UIImageView!
    @IBOutlet weak var kennyView8: UIImageView!
    @IBOutlet weak var kennyView9: UIImageView!
    
    var kennyArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        scoreLabel.text = "Score: \(score)"
        counter = 10
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeController), userInfo: nil, repeats: true)
        kennyView1.isUserInteractionEnabled = true
        kennyView2.isUserInteractionEnabled = true
        kennyView3.isUserInteractionEnabled = true
        kennyView4.isUserInteractionEnabled = true
        kennyView5.isUserInteractionEnabled = true
        kennyView6.isUserInteractionEnabled = true
        kennyView7.isUserInteractionEnabled = true
        kennyView8.isUserInteractionEnabled = true
        kennyView9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        
        kennyView1.addGestureRecognizer(recognizer1)
        kennyView2.addGestureRecognizer(recognizer2)
        kennyView3.addGestureRecognizer(recognizer3)
        kennyView4.addGestureRecognizer(recognizer4)
        kennyView5.addGestureRecognizer(recognizer5)
        kennyView6.addGestureRecognizer(recognizer6)
        kennyView7.addGestureRecognizer(recognizer7)
        kennyView8.addGestureRecognizer(recognizer8)
        kennyView9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kennyView1, kennyView2, kennyView3, kennyView4, kennyView5, kennyView6, kennyView7, kennyView8, kennyView9]
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTheKenny), userInfo: nil, repeats: true)
        hideTheKenny()

    }
    @objc func hideTheKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    @objc func clickedView(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    @objc func timeController(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter == 0{
            timer.invalidate()
            kennyTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score
                self.highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's Over", message: "Do you want play again?", preferredStyle: UIAlertController.Style.alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score = 0
                self.counter = 10
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = "Time: \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeController), userInfo: nil, repeats: true)
                self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTheKenny), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(cancelButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            }
    }


}

