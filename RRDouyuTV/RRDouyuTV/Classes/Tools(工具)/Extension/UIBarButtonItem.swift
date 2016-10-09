//
//  File.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 10/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem{
    convenience init(name : String,highName : String,size : CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named:name), for: .normal)
        btn.setImage(UIImage(named:highName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(customView:btn)
    }
}
