/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import AVFoundation
import TextToSpeechV1

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // UI elements
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var voicesTableView: UITableView!
    
    // Text to Speech service object
    var textToSpeech: TextToSpeech!
    
    // Audio player for playing synthesized text
    var player: AVAudioPlayer?
    
    // Defines the number of lines to be shown in the text view
    let kAmountOfLinesShown = CGFloat(7)
    
    // Stores names of voices to display in table view
    var voices: [String] = []
    
    // Voice selected by user in the table view
    var selectedVoice: String!
    
    // Constants for error handling.
    let kTextFieldEmptyAlertText = "Please enter something for me to say!"
    let kTextFieldEmptyAlertTitle = "Text Field Empty"
    let kSelectVoiceAlertText = "Please choose a voice for me to use."
    let kSelectVoiceAlertTitle = "No Voice Selected"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate Text to Speech service
        textToSpeech = TextToSpeech(apiKey: Credentials.TextToSpeechApiKey)
        
        // Load the supported voices
        loadVoices()
        
        // Set up the speak button
        speakButton.setTitle("SPEAK", for: .normal)
        speakButton.setTitleColor(UIColor.white, for: .normal)
        
        // Set up the text view
        let maxHeight: CGFloat = textView.font!.lineHeight * kAmountOfLinesShown
        textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: maxHeight))
        textView.text = "All the problems of the world could be settled easily if men were only willing to think."
        textView.borderColor = UIColor.lightGray
        textView.borderWidth = 1
        
        // Set up the table view
        voicesTableView.delegate = self
        voicesTableView.dataSource = self
        voicesTableView.borderWidth = 1.0
        voicesTableView.borderColor = UIColor.lightGray
    }
    
    /** Reload the table upon receiving data to display. */
    func receivedDataNotification(object: AnyObject) {
        self.voicesTableView.reloadData()
    }
    
    func loadVoices() {
        let failure = { (error: Error) in print(error) }
        textToSpeech.getVoices(failure: failure) { voices in
            for voice in voices {
                self.voices.append(voice.name)
            }
            DispatchQueue.main.async {
                self.voicesTableView.reloadData()
            }
        }
    }
    
    /** Error handling to make sure user fills in required fields before speaking. */
    func alertUser(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Handle errors and call Text to Speech service to output the audio of the text when the button is pressed.
     - paramater sender: AnyObject that includes information about who is pressing the button.
     */
    @IBAction func pressedSpeakButton() {
        // Ensure there is text
        guard let text = textView.text else {
            return
        }
        
        // Ensure text is not empty
        if text == "" {
            alertUser(title: kTextFieldEmptyAlertTitle, text: kTextFieldEmptyAlertText)
            return
        }
        
        // Ensure a voice is selected
        guard let voice = selectedVoice else {
            alertUser(title: kSelectVoiceAlertTitle, text: kSelectVoiceAlertText)
            return
        }
        
        // Synthesize the text
        let failure = { (error: Error) in print(error) }
        textToSpeech.synthesize(
            text,
            voice: voice,
            audioFormat: .wav,
            failure: failure)
        {
            data in
            do {
                self.player = try AVAudioPlayer(data: data)
                self.player!.play()
            } catch {
                print("Failed to create audio player.")
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = voicesTableView.cellForRow(at: indexPath) {
            if let voice = cell.textLabel?.text {
                selectedVoice = voice
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoicesTableViewCell", for: indexPath)
        cell.textLabel?.text = voices[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voices.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
