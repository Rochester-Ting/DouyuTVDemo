//
//  CycleModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 图片上的名字
    var title : String = ""
    // 图片
    var pic_url : String = ""
    // 对应的直播间
    var room : [String : NSObject]?{
        didSet {
            guard let room = room else {return}
            achors = RAchorModel(dict: room)
        }
    }
    var achors : RAchorModel?
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
