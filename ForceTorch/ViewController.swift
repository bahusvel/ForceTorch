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
	
    static let camera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
	static var currentBrightness: Float = 0.0
	var buttonLocked = false
	var buttonStart: CGFloat = 0.0
	var buttonDiameter: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
		buttonStart = buttonView.center.y
		buttonDiameter = buttonView.frame.height
		setDisplay(ViewController.currentBrightness)
		if ViewController.currentBrightness > 0.0 {
			buttonView.center.y = buttonDiameter / 2
		}
        // Do any additional setup after loading the view, typically from a nib.
    }
	
	func setDisplay(power: Float){
		displayView.power = power
		displayView.setNeedsDisplay()
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	static func setTorch(level: Float){
		do {
			try camera.lockForConfiguration()
			if level == 0.0 {
				camera.torchMode = .Off
			} else {
				try camera.setTorchModeOnWithLevel(level)
			}
			currentBrightness = level
			camera.unlockForConfiguration()
		} catch {
			print("Error could not change the flashlight brightness")
		}
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
				setDisplay(touchForce)
				ViewController.setTorch(touchForce)
			}
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if !buttonLocked {
			buttonView.center.y = buttonStart
			setDisplay(0.0)
			ViewController.setTorch(0.0)
		} else {
			buttonView.center.y = buttonDiameter / 2
		}
    }

}

