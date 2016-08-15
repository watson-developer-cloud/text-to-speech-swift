//
//  UIViewExtensions.swift
//  WatsonSpeaks
//
//  Created by Sarah Chen on 8/15/16.
//  Copyright © 2016 IBM-MIL. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// Allows you to modify the corner radius of a view in storyboard
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(CGColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.CGColor
        }
    }
}
