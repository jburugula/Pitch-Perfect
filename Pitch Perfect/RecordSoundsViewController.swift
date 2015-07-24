//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Janaki Burugula on Jul/09/2015.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{
    
    @IBOutlet weak var recordingLebel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    // Hints to user to indicate various stages of recording
    
    let recordStartText = "Tap to record"
    let recordRecordingText = "Recording in progress..."
    
    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        recordButton.enabled = true
        stopButton.hidden = true
        recordingLebel.text = recordStartText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordButton.enabled = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        
        // Disable record button
        recordButton.enabled = false
        
        // Enable stop button
        stopButton.hidden = false
        
        // display hint for user that recording is in progress...
        recordingLebel.text = recordRecordingText
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var error: NSError?
        
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        if (flag)
        {
            // save recorded audio file
            let recordedAudio =  RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            // perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            
            recordButton.enabled = true
            stopButton.hidden = true
            recordingLebel.text = recordStartText
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "stopRecording")
        {
            let playSoundsVC:playSoundViewController = segue.destinationViewController as! playSoundViewController
            let data = sender as!  RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }
    
}

