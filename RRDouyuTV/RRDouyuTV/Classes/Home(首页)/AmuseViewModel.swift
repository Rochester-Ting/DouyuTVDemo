//
//  AmuseViewModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 17/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var amuseModels : [RGameModel] = [RGameModel]()
    func requestAmuseData(finished:@escaping ()->()){
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            // 将result转成字典
            guard let dataDict = result as? [String : NSObject] else{return}
            // 取出需要要转换的部分
            guard let dataArray = dataDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray{
                self.amuseModels.append(RGameModel(dict: dict))
            }
            finished()
        }
    }
}
