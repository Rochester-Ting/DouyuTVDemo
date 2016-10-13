//
//  NetworkTools.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 13/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    class func requestData(type : MethodType,urlString : String ,paramters : [String : NSString]? = nil,finishedCallBack : @escaping (_ result : AnyObject)->()) {
        let methodType = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: methodType, parameters: paramters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            finishedCallBack(result as AnyObject)
            
        }

        
    }
}

