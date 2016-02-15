//
//  ViewController.swift
//  ForceTorch
//
//  Created by denis lavrov on 23/01/16.
//  Copyright © 2016 Denis Lavrov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let camera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where traitCollection.forceTouchCapability == .Available {
            do{
                try camera.lockForConfiguration()
                try camera.setTorchModeOnWithLevel(Float(touch.force / touch.maximumPossibleForce))
                camera.unlockForConfiguration()
            } catch {
                print("Error could not change the flashlight brightness")
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        do{
            try camera.lockForConfiguration()
            camera.torchMode = .Off
            camera.unlockForConfiguration()
        } catch {
            print("Error could not change the flashlight brightness")
        }
    }

}

