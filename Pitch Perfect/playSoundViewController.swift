//
//  playSoundViewController.swift
//  Pitch Perfect
//
//  Created by Janaki Burugula on Jul/12/2015.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    var error:NSError?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: &error)
        
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
        
        playSound(0.5)
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        playSound(2.0)
        
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDartVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    
    func playAudioWithVariablePitch(pitch:Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime:nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        
        audioPlayerNode.play()
        
        
    }
    
    private func playSound(rate: Float) {
        // Stop audioEngine to eliminate sound overlap
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    
    @IBAction func stopAllPlay(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
