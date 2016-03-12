//
//  DisplayView.swift
//  ForceTorch
//
//  Created by denis lavrov on 13/03/16.
//  Copyright © 2016 Denis Lavrov. All rights reserved.
//

import UIKit

@IBDesignable
class DisplayView: UIView {
	
	var power: Float = 0.0

    override func drawRect(rect: CGRect) {
		let pString = String(format: "%.0f", power * 100.0)
        ForceTorchKit.drawDisplay(power: pString)
    }

}
