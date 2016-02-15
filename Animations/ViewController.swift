//
//  ViewController.swift
//  Animations
//
//  Created by yanze on 1/30/16.
//  Copyright © 2016 River Inn Technology. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: image view
    @IBOutlet weak var imageView: UIImageView!
    
    
    // volum slider
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    //MARK: gif image control
    var count = 0
    var timer = NSTimer()
    var isAnimating = true
    
    //MARK: watching timer
    @IBOutlet weak var buttonText: UIButton!
    @IBOutlet weak var totalWatching: UILabel!
    var watchTimer = NSTimer()
    var totalWatchtimer = 0
    
    //MARK: background music
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "doAnimation", userInfo: nil, repeats: true)
        
        totalWatching.text = "0"
        watchTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseWatchingTimer"), userInfo: nil, repeats: true)
        
        backgroundMusic()
        
    }
    
    func backgroundMusic() {
        let audioPath = NSBundle.mainBundle().pathForResource("mySound", ofType: "mp3")!  // this find music location path when file is not in Asserts folder
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            player.play()
        }
        catch {
            print("no music available")
        }
    }
    
    func musicPause() {
        player.pause()
    }
    
    @IBAction func musicVolumeControl(sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func doAnimation() {
        if count < 9 {
            imageView.image = UIImage(named: "tmp-\(count).gif")
            count++
        }
        else {
            count = 0
        }
    }

    @IBAction func updateImagePressed(sender: UIButton) {
        if isAnimating {
            musicPause()
            timer.invalidate()
            buttonText.setTitle("I'm hungry!", forState: .Normal)
            isAnimating = false
        }
        else {
            backgroundMusic()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "doAnimation", userInfo: nil, repeats: true)
            buttonText.setTitle("I'm not hungry!", forState: .Normal)
            isAnimating = true
        }
    }
    
    func increaseWatchingTimer() {
        totalWatchtimer++
        totalWatching.text = String(totalWatchtimer)
    }
    

    
    
}
