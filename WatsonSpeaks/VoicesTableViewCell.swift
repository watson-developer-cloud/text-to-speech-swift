//
//  VoicesTableViewCell.swift
//  WatsonSpeaks
//
//  Created by Sarah Chen on 8/12/16.
//  Copyright © 2016 IBM-MIL. All rights reserved.
//

import UIKit

class VoicesTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var voiceNavLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupVoiceCell(name: String){
        //self.textLabel?.text = name
        //self.textLabel?.textColor = UIColor.blackColor()
        self.voiceNavLabel.text = name
    }

}
