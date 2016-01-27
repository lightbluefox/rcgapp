//
//  RCGButton.swift
//  RCGApp
//
//  Created by iFoxxy on 17.07.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class RCGButton: UIButton {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    
        let context = UIGraphicsGetCurrentContext();
        let color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        CGContextFillRect(context, self.bounds)
    
    }
    
}
