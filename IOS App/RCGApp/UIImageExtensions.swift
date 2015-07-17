//
//  UIImageExtensions.swift
//  RCGApp
//
//  Created by iFoxxy on 01.07.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit
extension UIImage {
    var rounded: UIImage {
        let imageView = UIImageView(image: self);
        imageView.layer.cornerRadius = size.height < size.width  ? size.height/30 : size.width/30
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

extension String {
    var formatedDate: String {
        let dateFull = self
        let dateformatter = NSDateFormatter();
        dateformatter.timeZone = .localTimeZone();
        dateformatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateObject : NSDate! = dateformatter.dateFromString(dateFull)
        dateformatter.dateFormat = "dd.MM.YYYY"
        var dateShort = dateformatter.stringFromDate(dateObject!);
        return dateShort
    }

}