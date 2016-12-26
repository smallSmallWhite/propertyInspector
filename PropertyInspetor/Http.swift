//
//  Http.swift
//  PropertyInspetor
//
//  Created by admin on 16/12/26.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
enum HttpMethod :String {
    case GET
    case POST
}

class Http: NSObject {
    
    static func getDataFormWeb(method:HttpMethod,url:String,parameters:[String : AnyObject]? = nil,headers: [String : String]? = nil,sucess:(status:Bool,data:NSData)->Void,failed:(status:Bool,error:NSError)->Void) {
        
        
        switch method  {
        case .GET :
            Alamofire.request(.GET, url).responseJSON(completionHandler: { (result) in
        
                guard result.result.error == nil else {
                    failed(status: false, error: result.result.error!)
                    return
                }
                
                sucess(status: true,data: result.data!)
            })
            
        case .POST:
            
            Alamofire.request(.POST, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: headers).responseJSON(completionHandler: { (result) in
                print(result.request?.URLString)
                guard result.result.error == nil else {
                    failed(status: false, error: result.result.error!)
                    return
                }
                sucess(status: true,data: result.data!)
                
            })
            
        default:
            Alamofire.request(.GET, url).responseJSON { (result) in
                guard result.result.error == nil else {
                    failed(status: false, error: result.result.error!)
                    return
                }
                
                sucess(status: true,data: result.data!)            }
        }
        
    }

}
