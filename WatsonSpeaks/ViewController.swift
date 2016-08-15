//
//  ViewController.swift
//  WatsonSpeaks
//
//  Created by Sarah Chen on 8/9/16.
//  Copyright © 2016 IBM-MIL. All rights reserved.
//

import UIKit

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
        
        // Set up speech to text service with credentials and password received from
        // services app on Bluemix.
        tts = ToSpeech(username: creds.username, password: creds.password)
        
        setupSpeakButton()
        setupTextView()
        setupVoices()
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
    
    private func setupVoices() {
        voices.append("Kate")
        voices.append("Allison")
        voices.append("Lisa")
        voices.append("Michael")
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
        switch selectedVoice {
            case "Kate":
                tts.kateSpeaking(text)
            case "Allison":
                tts.allisonSpeaking(text)
            case "Lisa":
                tts.lisaSpeaking(text)
            case "Michael":
                tts.michaelSpeaking(text)
        default:
            tts.kateSpeaking(text)
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
        if ((index >= 0) || (index < voices.count)) {
            return voices[index]
        }
        return nil
    }
    
    /* Display all the voices we inputted in the function setupVoices to be shown in the
     * table view. 
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Grab each cell to input the desired string.
        guard let cell = tableView.dequeueReusableCellWithIdentifier("VoicesTableViewCell", forIndexPath: indexPath) as? VoicesTableViewCell else {
            return UITableViewCell()
        }
        // Fetch voice to display
        if let voice = self.getVoiceForIndex(indexPath.row) {
            // Set the name
            cell.textLabel!.text = voice
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
        return voices.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}

