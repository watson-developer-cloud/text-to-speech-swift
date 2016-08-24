//
//  ViewController.swift
//  WatsonSpeaks
//
//  Created by Sarah Chen on 8/9/16.
//  Copyright © 2016 IBM-MIL. All rights reserved.
//

import UIKit
import TextToSpeechV1
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    // Do any additional setup after loading the view, typically from a nib.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tts = TextToSpeech(username: "YOUR USERNAME HERE", password: "YOUR PASSWORD HERE")
        
        tts.synthesize("All the problems of the world could be settled easily if men were only willing to think.",
                       voice: SynthesisVoice.GB_Kate,
                       audioFormat: AudioFormat.WAV,
                       failure: { error in
                        print("error was generated \(error)")
        }) { data in
            
            do {
                self.player = try AVAudioPlayer(data: data)
                self.player!.play()
            } catch {
                print("Couldn't create player.")
            }
            
        }
    }
}