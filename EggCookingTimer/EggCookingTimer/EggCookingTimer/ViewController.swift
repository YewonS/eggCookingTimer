//
//  ViewController.swift
//  EggCookingTimer
//
//  Created by Yewon Seo on 2020/04/06.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let timesNeeded = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var timesPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func resultSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let result = sender.currentTitle!
        totalTime = timesNeeded[result]!
        
        progressBar.setProgress(0.0, animated: true)
        timesPassed = 0
        titleLabel.text = result
        
        DispatchQueue.main.async{
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func updateTimer() {
        
        if timesPassed < totalTime {
            
            timesPassed += 1
            let progress = Float(timesPassed) / Float(totalTime)
            progressBar.setProgress(Float(progress), animated: true)
         
        } else {
            
            timer.invalidate()
            titleLabel.text = "DONE:) Enjoy your eggs!"
            
            let alarmSound = Bundle.main.url(forResource: "Tada", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: alarmSound!)
            player.play()
            
        }
        
    }
    
    
}

