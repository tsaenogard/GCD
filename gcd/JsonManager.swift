//
//  JsonManager.swift
//  GCD
//
//  Created by smallHappy on 2017/3/7.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class JsonManager: NSObject {

    private static let instance = JsonManager()
    static var sharedInstance: JsonManager {
        return self.instance
    }
    
    func getJsonObject(jsonURL url: URL, body: Data?, timeoutInterval seccond: Double = 20, finish: @escaping (_ object: Any?) -> Void) {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: seccond)
        request.httpMethod = (body == nil ? "GET" : "POST")
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //取得資料失敗
            if error != nil {
                finish(nil)
                return
            }
            if data == nil {
                finish(nil)
                return
            }
            //取得資料成功
            do {
                //結束
                let result = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                finish(result)
            } catch {
                finish(nil)
            }
        }
        task.resume()
    }
    
}
