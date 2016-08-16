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
    
    private var tts: TextToSpeech!      /* tts object to use TextToSpeech. */
    var player: AVAudioPlayer?          /* Object used to play audio in app. */
    var voiceNames: [String]
    
    /* Service's credentials to authenticate. */
    init(username: String, password: String) {
        tts = TextToSpeech(username: username, password: password)
        self.voiceNames = []
    }
    
    /* Synthesize text to audio. Kate selected for which voice to be used for synthesis.
     * Returns the text in audio format specified and uses callback to output the audio.
    */
    
    //
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
    
    func loadVoices() {
        var voices:[Voice] = []
        tts.getVoices({ error in
            print("error was generated \(error)")
            }) { data in
                voices = data
                for voice in voices {
                    self.voiceNames.append(voice.name)
                }
                self.receivedDataFromServer()
            }
    }
    
    func receivedDataFromServer() {
        NSNotificationCenter.defaultCenter().postNotificationName("ReceivedData", object: nil)
    }
    
}