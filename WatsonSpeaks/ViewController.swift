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
    
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var voicesTableView: UITableView!
    
    private let kTextToSpeechPlaceholderText = NSLocalizedString("What would you like me to say?", comment: "")
    private var tts:TextToSpeech!
    private let kAmountOfLinesShown = CGFloat(7)
    // Comment out
    private let creds = Credentials.sharedInstance
    var voices: [String] = []
    
    // Do any additional setup after loading the view, typically from a nib.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tts = TextToSpeech(username: creds.username, password: creds.password)
        
//        tts.synthesize("All the problems of the world could be settled easily if men were only willing to think.",
//                       voice: SynthesisVoice.GB_Kate,
//                       audioFormat: AudioFormat.WAV,
//                       failure: { error in
//                        print("error was generated \(error)")
//        }) { data in
//            
//            do {
//                self.player = try AVAudioPlayer(data: data)
//                self.player!.play()
//            } catch {
//                print("Couldn't create player.")
//            }
//
//        }
        setupSpeakButton()
        setupTextField()
        setupTextView()
        loadVoices()
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupSpeakButton() {
        speakButton.setTitle("SPEAK", forState: .Normal)
        speakButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    private func setupTextView() {
        let maxHeight:CGFloat = (textView.font?.lineHeight)! * kAmountOfLinesShown
        textView.sizeThatFits(CGSizeMake(textView.frame.size.width, maxHeight))
        textView.text = "All the problems of the world could be settled easily if men were only willing to think."
        textView.layer.borderColor = UIColor.blackColor().CGColor
        textView.layer.borderWidth = 1
    }
    
    private func setupTextField() {
        textField.hidden = true
        textField.text = "All the problems of the world could be settled easily if men were only willing to think."
//        textField.attributedPlaceholder = NSAttributedString(string:kTextToSpeechPlaceholderText,
//                                                             attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        textField.layer.borderColor = UIColor.grayColor().CGColor
        textField.layer.borderWidth = 1
    }

    @IBAction func pressedSpeakButton(sender: AnyObject) {
        guard let text = textView.text else {
            return
        }
        if text == "" {
            let alert = UIAlertController(title: "Text Field Empty", message: "Please enter something for me to say!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        //own function, organize the calls to watson service so people can clearly see how the services work.
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
    


}

// Table View Methods
extension ViewController : UITableViewDelegate, UITableViewDataSource {

    private func setupTableView() {
        self.voicesTableView.delegate = self
        self.voicesTableView.dataSource = self
        //voicesTableView.registerClass(VoicesTableViewCell.self, forCellReuseIdentifier: "VoicesTableViewCell")
    }
    
    func loadVoices() {
        voices.append("Kate")
        voices.append("Allison")
        voices.append("Lisa")
        voices.append("Michael")
    }
    
    func getVoiceForIndex(index: Int) -> String? {
        if ((index >= 0) || (index < voices.count)) {
            return voices[index]
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("VoicesTableViewCell", forIndexPath: indexPath) as? VoicesTableViewCell else {
            return UITableViewCell()
        }
        // Fetch voice to display
        if let voice = self.getVoiceForIndex(indexPath.row) {
            //sets the name of the label to be
            cell.voiceNavLabel!.text = voice
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voices.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}

