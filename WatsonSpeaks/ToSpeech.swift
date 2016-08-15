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
    
    /* Service's credentials to authenticate. */
    init(username: String, password: String) {
        tts = TextToSpeech(username: username, password: password)
    }
    
    /* Synthesize text to audio. Kate selected for which voice to be used for synthesis.
     * Returns the text in audio format specified and uses callback to output the audio.
    */
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
    
    /* Synthesize text to audio with Allison's voice. */
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
    
    /* Synthesize text to audio with Michael's voice. */
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
    
    /* Synthesize text to audio with Lisa's voice. */
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