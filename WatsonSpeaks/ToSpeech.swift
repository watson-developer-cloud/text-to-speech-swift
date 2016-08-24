//
//  ToSpeech.swift
//  WatsonSpeaks
//
//  Created by Sarah Chen on 8/15/16.
//  Copyright © 2016 IBM-MIL. All rights reserved.
//

import Foundation
import TextToSpeechV1
import AVFoundation

class ToSpeech {
    
    /// tts object to use TextToSpeech.
    private var tts: TextToSpeech!
    
    /// Object used to play audio in the app.
    private var player: AVAudioPlayer?
    
    /// Array to store all the voices to use.
    var voiceNames: [String]
    
    /** Service's credentials to authenticate. */
    init(username: String, password: String) {
        tts = TextToSpeech(username: username, password: password)
        self.voiceNames = []
    }
    
    /** 
     Synthesize text to audio. Returns the text in audio format specified and uses
     the callback to output the audio.
     
     - paramater text: A string object that includes what to output as the audio
     - paramater voice: A SynthesisVoice object that identifies which voice to use
    */
    func synthesizeVoice(text: String, voice: SynthesisVoice) {
        tts.synthesize(text,
                       voice: voice,
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
    
    /** Find all available voices for user to choose from. */
    func loadVoices() {
        var voices:[Voice] = []
        tts.getVoices({ error in
            print("error was generated \(error)")
            }) { data in
                voices = data
                for voice in voices {
                    // Splice 'Voice' out of the name.
                    let range = voice.name.rangeOfString("Voice")
                    let splicedName = voice.name[voice.name.startIndex..<range!.startIndex]
                    
                    // Append the spliced string into the array voiceNames.
                    self.voiceNames.append(splicedName)
                }
                
                // Notify controller that data has been received in the model.
                self.receivedDataFromServer()
            }
    }
    
    /** Function to notify any listening agents on the Notification, "ReceivedData". */
    func receivedDataFromServer() {
        NSNotificationCenter.defaultCenter().postNotificationName("ReceivedData", object: nil)
    }
    
}