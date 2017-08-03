//
//  ProfileModel.swift
//  GCD
//
//  Created by smallHappy on 2017/3/8.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class ProfileModel: NSObject {
    
    private static let instance = ProfileModel()
    static var shareInstance: ProfileModel {
        return self.instance
    }
    
    var age: Int?
    var job: String?
    var name: String?
    
    enum ProfileModelError: Error {
        case inputIsNil
        case parseFail
    }
    
    func setValue(_ object: Any?) throws {
        if object == nil { throw ProfileModelError.inputIsNil }
        guard let dictionary = object as? [String: Any] else { throw ProfileModelError.parseFail }
        guard let _age = dictionary["age"] as? String else { throw ProfileModelError.parseFail }
        self.age = Int(_age)
        guard let _job = dictionary["job"] as? String else { throw ProfileModelError.parseFail }
        self.job = _job
        guard let _name = dictionary["name"] as? String else { throw ProfileModelError.parseFail }
        self.name = _name
    }

}
