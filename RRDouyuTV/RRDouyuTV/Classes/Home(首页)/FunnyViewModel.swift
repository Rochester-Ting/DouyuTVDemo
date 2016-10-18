//
//  FunnyViewModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 18/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class FunnyViewModel {
    lazy var funnyModels : [RAchorModel] = [RAchorModel]()
    func requestFunnyData(finished:@escaping ()->()){
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", paramters: ["limit" : "30", "offset" : "0"]) { (result) in
            // 将result转成字典
            guard let dictData = result as? [String : NSObject] else {return}
            // 获取需要转换的数组
            guard let dataArray = dictData["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray{
                self.funnyModels.append(RAchorModel(dict: dict))
                finished()
            }
        }
    }
}
