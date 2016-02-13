//
//  SettingsViewController.swift
//  AccelDraw
//
//  Created by Samuel Raudabaugh on 2/4/16.
//  Copyright © 2016 Cornell Tech. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(red: CGFloat, green: CGFloat, blue: CGFloat)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var brushPreviewView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var red = CGFloat(0.0)
    var green = CGFloat(0.0)
    var blue = CGFloat(0.0)

    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    @IBAction func done(sender: AnyObject) {
        done()
    }
    
    func done() {
        dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.settingsViewControllerFinished(CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                                blue: CGFloat(blueSlider.value))
    }

}
