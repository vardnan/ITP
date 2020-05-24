//
//  Extension.swift
//  RemindApp
//
//  Created by TC_XHJ on 2020/3/11.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Create Pure Color Image From Color
    /// - Parameters:
    ///   - color: UIColor
    ///   - size: CGSize
    class func createImage(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
}
