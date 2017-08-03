//
//  InfoView.swift
//  GCD
//
//  Created by smallHappy on 2017/3/8.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewW = frame.size.width
//        let viewH = frame.size.height
        let gap: CGFloat = 10
        
        let labelW = viewW - gap * 2
        let labelH: CGFloat = 21
        var _frame = CGRect(x: gap, y: gap, width: labelW, height: labelH)
        self.label1 = UILabel(frame: _frame)
        self.label1.textColor = UIColor.darkGray
        self.addSubview(self.label1)
        
        _frame.origin.y += (labelH + gap)
        self.label2 = UILabel(frame: _frame)
        self.label2.textColor = UIColor.darkGray
        self.addSubview(self.label2)
        
        _frame.origin.y += (labelH + gap)
        self.label3 = UILabel(frame: _frame)
        self.label3.textColor = UIColor.darkGray
        self.addSubview(self.label3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
