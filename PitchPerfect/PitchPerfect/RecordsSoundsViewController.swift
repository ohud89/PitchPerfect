//
//  RecordsSoundsViewController.swift
//  PitchPerfect
//
//  Created by Ohud Alessa on 16/10/2018.
// follow the Udacity toturial
//  Copyright © 2018 OHUD. All rights reserved.

//

import UIKit
import AVFoundation


class RecordsSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var recordlbl: UILabel!
    
    @IBOutlet weak var stopBtn: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopBtn.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK:  toggol the record, stopRecord buttons
    
    func toggoleRecord(_ recording: Bool){
        if recording{
            recordBtn.isEnabled = false
            stopBtn.isEnabled = true
            recordlbl.text = "Recording in progress.."
        }
        else{
            recordBtn.isEnabled = true
            stopBtn.isEnabled = false
            recordlbl.text = "Tap to record"
        }
        
    }
    
    
    
    @IBAction func record(_ sender: Any) {
       
        toggoleRecord(true)
        
        // code for recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let rName = "recordedFile.wav"
        let pathA = [dirPath, rName]
        let fullPath = URL(string: pathA.joined(separator: "/"))

        // session to aquire the speaker
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: fullPath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecord(_ sender: Any) {
       toggoleRecord(false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    //MARK: Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "goToVoiceChanger", sender: audioRecorder.url)
        }
        else{
            print("recording fails")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVoiceChanger"{
            let playSounds = segue.destination as! PlaySoundsViewController
            
            let recordedURL = sender as! URL
            playSounds.recordedAudioURL = recordedURL
        }
    }
}

