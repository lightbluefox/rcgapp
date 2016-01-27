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
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
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
        let dateShort = dateformatter.stringFromDate(dateObject!);
        return dateShort
    }
}
extension UIApplication {
    
    class func appVersion() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }
    
    class func appBuild() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    }
    
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
        
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
}
