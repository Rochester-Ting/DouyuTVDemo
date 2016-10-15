//
//  RGameModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 15/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RGameModel: NSObject {
    // 房间列表
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else {return}
            for dict in room_list{
               anchors.append(RAchorModel(dict: dict))
            }
        }
    }
    // 分组名称
    var tag_name : String = ""
    // 组显示的图标
    var icon_name : String = "home_header_normal"

    // 定义一个主播的模型对象
    var anchors : [RAchorModel] = [RAchorModel]()
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_: Any?, forUndefinedKey: String?){}
    override init() {
        
    }
}
