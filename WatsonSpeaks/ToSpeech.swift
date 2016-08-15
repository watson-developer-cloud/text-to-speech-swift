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
    
    private var tts: TextToSpeech!
    var player: AVAudioPlayer?
    
    init(username: String, password: String) {
        tts = TextToSpeech(username: username, password: password)
    }
    
    func kateSpeaking(text: String) {
        tts.synthesize(text,
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
    
    func allisonSpeaking(text: String) {
        tts.synthesize(text,
                       voice: SynthesisVoice.US_Allison,
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
    
    func michaelSpeaking(text: String) {
        tts.synthesize(text,
                       voice: SynthesisVoice.US_Michael,
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
    
    func lisaSpeaking(text: String) {
        tts.synthesize(text,
                       voice: SynthesisVoice.US_Lisa,
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