//
//  GameViewModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 17/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var modelArrs : [RGameModel] = [RGameModel]()
    func requestGameData(finished :@escaping ()->()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", paramters: ["shortName" : "game"]) { (result) in
            // 将返回的数据转换成字典
            guard let dict = result as? [String : NSObject] else {return}
            // 取出字典的数组
            guard let arr = dict["data"] as? [[String : NSObject]] else { return }
            for dataDict in arr{
                self.modelArrs.append( RGameModel(dict: dataDict))
            }
            finished()
        }
    }
}
