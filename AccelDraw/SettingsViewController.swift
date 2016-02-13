//
//  SettingsViewController.swift
//  AccelDraw
//
//  Created by Samuel Raudabaugh on 2/4/16.
//  Copyright © 2016 Cornell Tech. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(red: CGFloat, green: CGFloat, blue: CGFloat, brushSize: CGFloat)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var brushPreviewView: UIImageView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var brushSizeSlider: UISlider!
    
    var red = CGFloat(0.0)
    var green = CGFloat(0.0)
    var blue = CGFloat(0.0)
    var brushSize = CGFloat(0.0)

    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        drawBrushPreview()
    }
    
    @IBAction func done(sender: AnyObject) {
        done()
    }
    
    func done() {
        dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.settingsViewControllerFinished(CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                                blue: CGFloat(blueSlider.value),
                                           brushSize: CGFloat(brushSizeSlider.value))
    }
    
    func drawBrushPreview() {
        UIGraphicsBeginImageContext(brushPreviewView.frame.size)
        
        let rect = CGRectMake(brushPreviewView.frame.size.width/2.0 - CGFloat(brushSizeSlider.value)/2.0,
                              brushPreviewView.frame.size.height/2.0 - CGFloat(brushSizeSlider.value)/2.0,
                              CGFloat(brushSizeSlider.value), CGFloat(brushSizeSlider.value))
        
        let path = UIBezierPath(ovalInRect: rect)
        
        UIColor(colorLiteralRed: Float(redSlider.value), green: Float(greenSlider.value), blue: Float(blueSlider.value),
                alpha: 1.0).setFill()
        
        path.fill()
        
        brushPreviewView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    @IBAction func sliderValueChanged(sender: AnyObject) {
        drawBrushPreview()
    }
}
