//
//  ViewController.swift
//  GCD
//
//  Created by smallHappy on 2017/3/7.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        self.button = UIButton()
        self.button.backgroundColor = UIColor(red: 136 / 255, green: 176 / 255, blue: 75 / 255, alpha: 1.0)
        self.button.setTitle("START", for: .normal)
        self.button.addTarget(self, action: #selector(self.onButtonAction), for: .touchUpInside)
        self.view.addSubview(self.button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let buttonH: CGFloat = 100
        self.button.frame = CGRect(x: 0, y: 0, width: buttonH, height: buttonH)
        self.button.center = self.view.center
        self.button.layer.cornerRadius = buttonH / 2
        self.button.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.button.isEnabled = false
        UIView.animate(withDuration: 1.2, animations: {
            self.button.alpha = 1.0
        }) { (value) in
            self.button.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onButtonAction() {
        UIView.animate(withDuration: 1.0, animations: {
            self.button.isEnabled = false
            self.button.frame.origin.y = UIScreen.main.bounds.height
        }) { (value) in
            let infoVC = InfoVC()
            self.navigationController?.pushViewController(infoVC, animated: false)
        }
    }

}
