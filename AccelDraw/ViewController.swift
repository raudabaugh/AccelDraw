//
//  ViewController.swift
//  AccelDraw
//
//  Created by Samuel Raudabaugh on 2/4/16.
//  Copyright © 2016 Cornell Tech. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, SettingsViewControllerDelegate {
    @IBOutlet weak var labelXAcceleration: UILabel!
    @IBOutlet weak var labelYAcceleration: UILabel!
    @IBOutlet weak var labelZAcceleration: UILabel!
    @IBOutlet weak var drawingView: UIImageView!

    var motionManager = CMMotionManager()
    
    var currPoint = CGPointMake(0, 0)
    
    var red = CGFloat(1.0)
    var green = CGFloat(0.0)
    var blue = CGFloat(0.0)
    var brushSize = CGFloat(5.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        motionManager.accelerometerUpdateInterval = 1.0/60.0
        
        motionManager.startDeviceMotionUpdatesToQueue(.mainQueue()) { (motion, error) in
            self.labelXAcceleration.text = String(format: "X: %6.2f", motion!.userAcceleration.x)
            self.labelYAcceleration.text = String(format: "Y: %6.2f", motion!.userAcceleration.y)
            self.labelZAcceleration.text = String(format: "Z: %6.2f", motion!.userAcceleration.z)
            
            let accel = CGPointMake(CGFloat(motion!.userAcceleration.x), CGFloat(motion!.userAcceleration.y))
            
            var nextPoint = CGPointMake(10*accel.x, 10*accel.y)
            nextPoint.x += self.currPoint.x
            nextPoint.y += self.currPoint.y
            
            nextPoint = self.keepInFrame(nextPoint)
            
            self.drawLine(fromPoint: self.currPoint, toPoint: nextPoint)
            
            self.currPoint = nextPoint
        }
    }
    
    func keepInFrame(var point: CGPoint) -> CGPoint {
        if point.x > self.drawingView.frame.width/2.0 {
            point.x = self.drawingView.frame.width/2.0
        }
        else if point.x < -self.drawingView.frame.width/2.0 {
            point.x = -self.drawingView.frame.width/2.0
        }
        if point.y > self.drawingView.frame.height/2.0 {
            point.y = self.drawingView.frame.height/2.0
        }
        else if point.y < -self.drawingView.frame.height/2.0 {
            point.y = -self.drawingView.frame.height/2.0
        }
        return point
    }
    
    func drawLine(fromPoint a: CGPoint, toPoint b: CGPoint) {
        UIGraphicsBeginImageContext(drawingView.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        drawingView.image?.drawInRect(CGRectMake(0, 0, drawingView.frame.size.width, drawingView.frame.size.height))
        
        let origin = CGPointMake(drawingView.frame.width/2.0, drawingView.frame.height/2.0)
        CGContextMoveToPoint(context, a.x+origin.x, a.y+origin.y)
        CGContextAddLineToPoint(context, b.x+origin.x, b.y+origin.y)
        
        CGContextSetLineWidth(context, brushSize)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetLineCap(context, .Round)
        
        CGContextStrokePath(context)
        
        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingsView = segue.destinationViewController as! SettingsViewController
        
        settingsView.red = red
        settingsView.green = green
        settingsView.blue = blue
        settingsView.brushSize = brushSize
        settingsView.delegate = self
    }
    
    func settingsViewControllerFinished(red: CGFloat, green: CGFloat, blue: CGFloat, brushSize: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.brushSize = brushSize
    }


}

