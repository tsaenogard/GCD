//
//  AuthorizationModel.swift
//  GCD
//
//  Created by smallHappy on 2017/3/8.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class AuthorizationModel: NSObject {
    
    private static let instance = AuthorizationModel()
    static var shareInstance: AuthorizationModel {
        return self.instance
    }
    
    var authorization: Bool?
    var version: String?
    
    enum AuthorizationModelError: Error {
        case inputIsNil
        case parseFail
    }
    
    func setValue(_ object: Any?) throws {
        if object == nil { throw AuthorizationModelError.inputIsNil }
        guard let dictionary = object as? [String: Any] else { throw AuthorizationModelError.parseFail }
        guard let _authorization = dictionary["authorization"] as? String else { throw AuthorizationModelError.parseFail }
        self.authorization = (_authorization == "YES" ? true : false)
        guard let _version = dictionary["version"] as? String else { throw AuthorizationModelError.parseFail }
        self.version = _version
    }

}
