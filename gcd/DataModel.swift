//
//  DataModel.swift
//  GCD
//
//  Created by smallHappy on 2017/3/8.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    private static let instance = DataModel()
    static var shareInstance: DataModel {
        return self.instance
    }
    
    var price: Int?
    var amount: Int?
    var performance: Int?
    
    enum DataModelError: Error {
        case inputIsNil
        case parseFail
    }
    
    func setValue(_ object: Any?) throws {
        if object == nil { throw DataModelError.inputIsNil }
        guard let dictionary = object as? [String: Any] else { throw DataModelError.parseFail }
        guard let _price = dictionary["price"] as? String else { throw DataModelError.parseFail }
        self.price = Int(_price)
        guard let _amount = dictionary["amount"] as? String else { throw DataModelError.parseFail }
        self.amount = Int(_amount)
        guard let _performance = dictionary["performance"] as? String else { throw DataModelError.parseFail }
        self.performance = Int(_performance)
    }
    
}
