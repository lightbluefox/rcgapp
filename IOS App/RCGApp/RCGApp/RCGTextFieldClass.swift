//
//  RCGTextFieldClass.swift
//  RCGApp
//
//  Created by iFoxxy on 13.08.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class RCGTextFieldClass: UITextField {

    //override init() {
       // super.init()
    //}
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        var imageView = UIImageView();
        imageView.image = UIImage(named: "textRectangle");
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 14);
        imageView.contentMode = UIViewContentMode.Left;
        self.rightView = imageView;
        self.rightViewMode = UITextFieldViewMode.Always
        }
}
