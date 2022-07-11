//
//  ViewController.swift
//  catchKenny
//
//  Created by Gökberk Ali Kulaç on 12.06.2022.
//

import UIKit

class ViewController: UIViewController {
    //Labels
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    //İmages
    @IBOutlet weak var homer1: UIImageView!
    @IBOutlet weak var homer2: UIImageView!
    @IBOutlet weak var homer3: UIImageView!
    @IBOutlet weak var homer4: UIImageView!
    @IBOutlet weak var homer5: UIImageView!
    @IBOutlet weak var homer6: UIImageView!
    @IBOutlet weak var homer7: UIImageView!
    @IBOutlet weak var homer8: UIImageView!
    @IBOutlet weak var homer9: UIImageView!
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var homerArray = [UIImageView]()
    var hideTimer = Timer()
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil{
            highestScore=0
            highScoreLabel.text = "High Score : \(highestScore)"
        }
        if let newScore = storedHighScore as? Int{
            highestScore = newScore
            highScoreLabel.text = "High Score : \(highestScore)"
            
        }
        homer1.isUserInteractionEnabled = true
        homer2.isUserInteractionEnabled = true
        homer3.isUserInteractionEnabled = true
        homer4.isUserInteractionEnabled = true
        homer5.isUserInteractionEnabled = true
        homer6.isUserInteractionEnabled = true
        homer7.isUserInteractionEnabled = true
        homer8.isUserInteractionEnabled = true
        homer9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        
        homer1.addGestureRecognizer(recognizer1)
        homer2.addGestureRecognizer(recognizer2)
        homer3.addGestureRecognizer(recognizer3)
        homer4.addGestureRecognizer(recognizer4)
        homer5.addGestureRecognizer(recognizer5)
        homer6.addGestureRecognizer(recognizer6)
        homer7.addGestureRecognizer(recognizer7)
        homer8.addGestureRecognizer(recognizer8)
        homer9.addGestureRecognizer(recognizer9)
        
        homerArray = [homer1,homer2,homer3,homer4,homer5,homer6, homer7 , homer8, homer9]
        
        counter = 10
        
        timeLabel.text = "Time : \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideHomers), userInfo: nil, repeats: true)
        hideHomers()
        
    }
    
    @objc func hideHomers(){
        for homer in homerArray {
            homer.isHidden = true
        }
        
       let random =  Int(arc4random_uniform(UInt32(homerArray.count-1)))
        homerArray[random].isHidden = false
    }
    
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Time : \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for homer in homerArray {
                homer.isHidden = true
            }
            
            //HighScore
            if self.score > self.highestScore {
                self.highestScore = self.score
                highScoreLabel.text = "High Score : \(self.highestScore)"
                UserDefaults.standard.set(self.highestScore, forKey: "highScore")
            }

            // Alert
            let alert = UIAlertController(title: "Time is up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Time : \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideHomers), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @objc func increseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }


}

