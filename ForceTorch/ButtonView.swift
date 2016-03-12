//
//  ButtonView.swift
//  ForceTorch
//
//  Created by denis lavrov on 13/03/16.
//  Copyright © 2016 Denis Lavrov. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonView: UIView {

    override func drawRect(rect: CGRect) {
        ForceTorchKit.drawButton()
	}

}
