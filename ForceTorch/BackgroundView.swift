//
//  Background.swift
//  ForceTorch
//
//  Created by denis lavrov on 13/03/16.
//  Copyright © 2016 Denis Lavrov. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        ForceTorchKit.drawUIBackground(frame: rect)
    }
	

}
