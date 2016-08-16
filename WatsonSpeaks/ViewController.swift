//
//  ViewController.swift
//  WatsonSpeaks
//
//  Created by Sarah Chen on 8/9/16.
//  Copyright © 2016 IBM-MIL. All rights reserved.
//

import UIKit
import TextToSpeechV1

class ViewController: UIViewController {
    
    //MARK - properties
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var voicesTableView: UITableView!
    
    private var tts:ToSpeech!                           /* ToSpeech object to use TextToSpeech service. */
    private let kAmountOfLinesShown = CGFloat(7)        /* Defines the number of lines to be shown in the text view. */
    
    private let creds = Credentials.sharedInstance      /* Credentials are stored in separate file. */
    
    var voices: [String] = []                           /* Stores names of voices to display in table view. */
    var selectedVoice: String!                          /* Voice selected by user in the table view. */
    
    // Do any additional setup after loading the view, typically from a nib.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Subscribe to notification changes when server returns data to app
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.receivedDataNotification(_:)), name: "ReceivedData", object: nil)
        
        // Set up speech to text service with credentials and password received from
        // services app on Bluemix.
        tts = ToSpeech(username: creds.username, password: creds.password)
        tts.loadVoices()
        
        setupSpeakButton()
        setupTextView()
        setupTableView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receivedDataNotification (object: AnyObject) {
        print("Received Data!")
        print (tts.voiceNames)
        self.voicesTableView.reloadData()
    }
    
    private func setupSpeakButton() {
        speakButton.setTitle("SPEAK", forState: .Normal)
        speakButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    private func setupTextView() {
        let maxHeight:CGFloat = (textView.font?.lineHeight)! * kAmountOfLinesShown
        textView.sizeThatFits(CGSizeMake(textView.frame.size.width, maxHeight))
        textView.text = "All the problems of the world could be settled easily if men were only willing to think."
        textView.borderColor = UIColor.lightGrayColor()
        textView.borderWidth = 1
    }

    @IBAction func pressedSpeakButton(sender: AnyObject) {
        guard let text = textView.text else {
            return
        }
        // Error handling to make sure that the text field is not empty.
        if text == "" {
            let alert = UIAlertController(title: "Text Field Empty", message: "Please enter something for me to say!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        // Uses user's selected voice to use when reading the text inputted.
        // TODO - Remove foreign voices, trim string, and/or add translation service
        switch selectedVoice {
//            case "Kate":
            case "en-GB_KateVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.GB_Kate)
//            case "Allison":
            case "en-US_AllisonVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.US_Allison)
//            case "Lisa":
            case "en-US_LisaVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.US_Lisa)
//            case "Michael":
            case "en-US_MichaelVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.US_Michael)
            case "pt-BR_IsabelaVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.BR_Isabela)
            case "ja-JP_EmiVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.JP_Emi)
            case "fr-FR_ReneeVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.FR_Renee)
            case "it-IT_FrancescaVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.IT_Francesca)
            case "es-ES_LauraVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.ES_Laura)
            case "es-US_SofiaVoice":
                tts.synthesizeVoice(text, voice: SynthesisVoice.US_Sofia)
        default:
            tts.synthesizeVoice(text, voice: SynthesisVoice.GB_Kate)
        }
    }
}

// Table View Methods
extension ViewController : UITableViewDelegate, UITableViewDataSource {

    private func setupTableView() {
        self.voicesTableView.delegate = self
        self.voicesTableView.dataSource = self
        
        self.voicesTableView.borderWidth = 1.0
        self.voicesTableView.borderColor = UIColor.lightGrayColor()
    }
    
    /* Check if index is valid. */
    func getVoiceForIndex(index: Int) -> String? {
        if ((index >= 0) || (index < tts.voiceNames.count)) {
            return tts.voiceNames[index]
        }
        return nil
    }
    
    /* Display all the voices we inputted in the function setupVoices to be shown in the
     * table view. 
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Grab each cell to input the desired string.
        let cell = tableView.dequeueReusableCellWithIdentifier("VoicesTableViewCell", forIndexPath: indexPath)
        // Fetch voice to display
        if let voice = self.getVoiceForIndex(indexPath.row) {
            // Set the name
            cell.textLabel!.text = voice
            cell.textLabel!.adjustsFontSizeToFitWidth = true
        }
        return cell
    }
    
    // Get the selected item
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = self.voicesTableView.cellForRowAtIndexPath(indexPath) {
            if let voice = cell.textLabel?.text {
                selectedVoice = voice
            }
        }
    }
    
    // The number of rows in the table view is set to be the number of voices in the voices array.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tts.voiceNames.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    

}