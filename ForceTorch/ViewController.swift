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

	@IBOutlet weak var sliderView: SliderView!
	@IBOutlet weak var displayView: DisplayView!
	@IBOutlet weak var buttonView: ButtonView!
	
    let camera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
	var buttonLocked = false
	var buttonStart: CGFloat = 0.0
	var buttonDiameter: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
		buttonStart = buttonView.center.y
		buttonDiameter = buttonView.frame.height
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where traitCollection.forceTouchCapability == .Available{
			if touch.view == buttonView {
				let touchPoint = touch.locationInView(sliderView)
				if touchPoint.y < 100.0 {
					buttonLocked = true
				} else {
					buttonLocked = false
				}
				if touchPoint.y >= buttonDiameter / 2 && touchPoint.y <= buttonStart{
					buttonView.center.y = touchPoint.y
				}
				let touchForce = Float(touch.force / touch.maximumPossibleForce)
				displayView.power = touchForce
				displayView.setNeedsDisplay()
				do {
					try camera.lockForConfiguration()
					if touchForce == 0.0 {
						camera.torchMode = .Off
					} else {
						try camera.setTorchModeOnWithLevel(touchForce)
					}
					camera.unlockForConfiguration()
				} catch {
					print("Error could not change the flashlight brightness")
				}
			}
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if !buttonLocked {
			buttonView.center.y = buttonStart
			displayView.power = 0.0
			displayView.setNeedsDisplay()
			do {
				try camera.lockForConfiguration()
				camera.torchMode = .Off
				camera.unlockForConfiguration()
			} catch {
				print("Error could not change the flashlight brightness")
			}
		} else {
			buttonView.center.y = buttonDiameter / 2
		}
    }

}

