//
//  RecommandViewModel.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 14/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RecommandViewModel: NSObject {
    
}

extension RecommandViewModel{
    /*
     1.推荐 http://capi.douyucdn.cn/api/v1/getbigDataRoom ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
     2.颜值 "http://capi.douyucdn.cn/api/v1/getVerticalRoom" 参数相同
     3.游戏 "http://capi.douyucdn.cn/api/v1/getHotCate" 参数相同
     */
 
    // MARK:- 发送首页的网络请求
    class func requestHomeData() {
        // MARK:- 获取推荐的数据
        // MARK:- 设置参数
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramters: ["limit" : "4","offset" : "0","time" : "\(interval)" as NSString]) { (resultRecommand) in
            print(resultRecommand)
            
            
            // MARK:- 获取颜值的数据
            NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paramters: ["limit" : "4","offset" : "0","time" : "\(interval)" as NSString]) { (resultBeatiful) in
                print(resultBeatiful)
                
                
                // MARK:- 获取游戏的数据
                NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", paramters: ["limit" : "4","offset" : "0","time" : "\(interval)" as NSString]) { (resultGame) in
                    print(resultGame)
                }

            }
        }
        
    }
}
