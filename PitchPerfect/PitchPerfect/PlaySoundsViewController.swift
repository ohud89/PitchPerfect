//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Ohud Alessa on 16/10/2018.
// follow the Udacity toturial
//  Copyright © 2018 OHUD. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL : URL!
    
    @IBOutlet weak var slow: UIButton!
    
    @IBOutlet weak var fast: UIButton!
    
    @IBOutlet weak var highPitch: UIButton!
    
    @IBOutlet weak var lowPitch: UIButton!
    
    @IBOutlet weak var echo: UIButton!
    
    @IBOutlet weak var reverb: UIButton!
    
    @IBOutlet weak var stop: UIButton!
    
    
    
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    // MARK: play sound
    @IBAction func playSound(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.7)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    

    
    @IBAction func stopPlayback(_ sender: Any) {
        stopAudio()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

 

}
