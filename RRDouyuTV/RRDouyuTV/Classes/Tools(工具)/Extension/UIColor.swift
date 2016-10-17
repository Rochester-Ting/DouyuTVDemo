//
//  UIColor.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 17/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    class func randomColor()->UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 256.0, green: CGFloat(arc4random_uniform(256)) / 256.0, blue: CGFloat(arc4random_uniform(256)) / 256.0, alpha: 1)
    }
}
