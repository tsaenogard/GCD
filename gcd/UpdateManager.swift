//
//  UpdateManager.swift
//  GCD
//
//  Created by smallHappy on 2017/3/7.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class UpdateManager: NSObject {
    
    //MARK: - shared instance
    fileprivate static let instance = UpdateManager()
    static var sharedInstance: UpdateManager {
        return self.instance
    }
    
    func getData(finish: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) {
            let url = URL(string: "http://www.smallyen.com/smallhappy/json.php?action=data")!
            JsonManager.sharedInstance.getJsonObject(jsonURL: url, body: nil, finish: { (object) in
                print("data = \(object)")
                do {
                    try DataModel.shareInstance.setValue(object)
                } catch DataModel.DataModelError.inputIsNil {
                    print("json object is nil")
                } catch DataModel.DataModelError.parseFail {
                    print("parsing object fail")
                } catch {
                    print("error")
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) {
            let url = URL(string: "http://www.smallyen.com/smallhappy/json.php?action=profile")!
            JsonManager.sharedInstance.getJsonObject(jsonURL: url, body: nil, finish: { (object) in
                print("profile = \(object)")
                do {
                    try ProfileModel.shareInstance.setValue(object)
                } catch ProfileModel.ProfileModelError.inputIsNil {
                    print("json object is nil")
                } catch ProfileModel.ProfileModelError.parseFail {
                    print("parsing object fail")
                } catch {
                    print("error")
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) {
            let url = URL(string: "http://www.smallyen.com/smallhappy/json.php?action=authorization")!
            JsonManager.sharedInstance.getJsonObject(jsonURL: url, body: nil, finish: { (object) in
                print("authorization = \(object)")
                do {
                    try AuthorizationModel.shareInstance.setValue(object)
                } catch AuthorizationModel.AuthorizationModelError.inputIsNil {
                    print("json object is nil")
                } catch AuthorizationModel.AuthorizationModelError.parseFail {
                    print("parsing object fail")
                } catch {
                    print("error")
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
            print("下載完成")
            finish()
        }
    }

}
