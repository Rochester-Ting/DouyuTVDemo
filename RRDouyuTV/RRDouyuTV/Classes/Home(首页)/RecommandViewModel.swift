//
//  RecommandViewModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 15/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RecommandViewModel{
    // MARK:- 设置游戏模型数组
    lazy var rGameModelArrs : [RGameModel] = [RGameModel]()
    // MARK:- 设置热门和颜值的
    lazy var rHotAchor : RGameModel = RGameModel()
    lazy var rBeautiAchor : RGameModel = RGameModel()
    // MARK:- 存储轮播图对象的数组
    lazy var cycleArr : [CycleModel] = [CycleModel]()
    
}

extension RecommandViewModel{
    /*
     1.推荐 http://capi.douyucdn.cn/api/v1/getbigDataRoom ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
     2.颜值 "http://capi.douyucdn.cn/api/v1/getVerticalRoom" 参数相同
     3.游戏 "http://capi.douyucdn.cn/api/v1/getHotCate" 参数相同
     */
    
    // MARK:- 发送首页的网络请求
    func requestHomeData(finishied :@escaping ()->()) {
        // MARK:- 获取推荐的数据
        // MARK:- 设置参数
        // http://capi.douyucdn.cn/api/v1/getbigDataRoom?limit=4&offset=0&time=1476508719
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramters: ["limit" : "4","offset" : "0","time" : "\(interval)" as NSString]) { (resultRecommand) in
            //            print(resultRecommand)
//            print(interval)
            self.rHotAchor.tag_name = "热门"
            self.rHotAchor.icon_name = "home_header_hot"
            guard let resultRecommandDict = resultRecommand as? [String : NSObject] else {return}
            guard let resultRecommandArr = resultRecommandDict["data"] as? [[String : NSObject]] else {return}
            
            for dict in resultRecommandArr{
                let itemArr = RAchorModel(dict: dict)
                self.rHotAchor.anchors.append(itemArr)
                
            }
            

            
            // MARK:- 获取颜值的数据
            NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paramters: ["limit" : "4","offset" : "0","time" : "\(interval)" as NSString]) { (resultBeatiful) in
                //                print(resultBeatiful)
                self.rBeautiAchor.tag_name = "颜值"
                self.rBeautiAchor.icon_name = "home_header_phone"
                // 将返回的数组转成字典
                guard let resultBeatifulDict = resultBeatiful as? [String : NSObject] else {return}
                // 将返回的字典转成数组
                guard let resultBeatifulArr = resultBeatifulDict["data"] as? [[String : NSObject]] else {return}

                //将数组转成模型
                
                for dict in resultBeatifulArr{
                    let itemArr = RAchorModel(dict:dict)
                    self.rBeautiAchor.anchors.append(itemArr)
                }
                
                // MARK:- 获取游戏的数据
                NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", paramters: ["limit" : "4","offset" : "0","time" : "\(interval)" as NSString]) { (resultGame) in
//                    print(resultGame)
                    // 将resultGame转成字典
                    guard let resultGameDict = resultGame as? [String : NSObject] else { return }
                    // 取出数组
                    guard let resultGameItemArr = resultGameDict["data"] as? [[String : NSObject]] else { return }
                    // 遍历字典数组数组
                    
                    for dict in resultGameItemArr {
                        let itemArr = RGameModel(dict: dict)

                        self.rGameModelArrs.append(itemArr)
                    }
                    self.rGameModelArrs.insert(self.rBeautiAchor, at: 0)
                    self.rGameModelArrs.insert(self.rHotAchor, at: 0)
                    
                    finishied()
                }
                
            }
        }
        
//        finishied()finishied
        
    }
    // MARK:- 获取首页轮播图
    func requestCycle(finished:@escaping ()->()) {
        NetworkTools.requestData(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", paramters: ["version" : "2.300"]) { (resultCycle) in
            // 转成字典
            guard let dict = resultCycle as? [String : NSObject] else {return}
            // 获取需要的数据
            guard let dataArray = dict["data"] as? [[String : NSObject]] else{return}
//            print(dataArray)
            // 转字典
            for dict in dataArray{
                self.cycleArr.append(CycleModel(dict: dict))
            }
            // 转成以后回调
            finished()
        }
    }
}

