//
//  PopVC.swift
//  GCD
//
//  Created by smallHappy on 2017/3/10.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

protocol PopVCDelegate {
    func popVC(didSelect stepperValue: Int)
}

class PopVC: UIViewController {
    
    var stepperValue: Double = 0
    var delegate: PopVCDelegate?
    
    var stepper: UIStepper!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.stepper = UIStepper()
        self.stepper.minimumValue = 0.0
        self.stepper.maximumValue = 10.0
        self.stepper.stepValue = 1.0
        self.stepper.value = self.stepperValue
        self.stepper.addTarget(self, action: #selector(self.onStepperAction(_:)), for: .valueChanged)
        self.view.addSubview(self.stepper)
        
        self.label = UILabel()
        self.label.text = "\(Int(self.stepper.value))"
        self.label.textColor = UIColor.darkGray
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let frameW = self.view.frame.size.width
//        let frameH = self.view.frame.size.height
        let gap: CGFloat = 10
        
        let stepperW: CGFloat = 94
        self.stepper.frame = CGRect(x: gap, y: gap, width: stepperW, height: 29)
        
        let labelX = gap + stepperW + gap
        let labelW = frameW - labelX - gap
        self.label.frame = CGRect(x: labelX, y: 0, width: labelW, height: 21)
        self.label.center.y = self.stepper.center.y
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onStepperAction(_ sender: UIStepper) {
        let result = Int(sender.value)
        self.label.text = "\(result)"
        self.delegate?.popVC(didSelect: result)
    }

}
