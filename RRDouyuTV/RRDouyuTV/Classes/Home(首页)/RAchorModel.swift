//
//  RAchorModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 15/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RAchorModel: NSObject {
    // 主播名字
    var nickname : String = ""
    // 房间名字
    var room_name : String = ""
    // 背景图片
    var vertical_src :String = ""
    // 在线观看人数
    var online : Int = 0
    // 房间ID
    var room_id : Int = 0
    // 是否是手机直播
    var isVertical : Int = 0
    // 所属游戏分组
    var game_name : String = ""
    /// 房间ID
    
    
    
    // 所在地区
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
