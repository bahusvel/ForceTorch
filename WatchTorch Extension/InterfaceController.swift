//
//  InterfaceController.swift
//  WatchTorch Extension
//
//  Created by denis lavrov on 28/03/16.
//  Copyright © 2016 Denis Lavrov. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

	@IBOutlet var group: WKInterfaceGroup!
	var state = true
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

	@IBAction func toggleWatch() {
		if state {
			group.setBackgroundColor(UIColor.blackColor())
		} else {
			group.setBackgroundColor(UIColor.whiteColor())
		}
		state = !state
	}
}
