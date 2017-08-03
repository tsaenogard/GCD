//
//  InfoVC.swift
//  GCD
//
//  Created by smallHappy on 2017/3/8.
//  Copyright © 2017年 SmallHappy. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    var authorizationView: InfoView!
    var profileView: InfoView!
    var dataView: InfoView!
    var loadingView: LoadingAnimatingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        let frameW = UIScreen.main.bounds.width
        let frameH = UIScreen.main.bounds.height
        let gap: CGFloat = 10
        let infoViewW: CGFloat = UIScreen.main.bounds.width - 20
        let infoViewH: CGFloat = 21 * 3 + 10 * 4
        
        let authorizationY = (frameH - infoViewH * 3 - gap * 2) / 2
        var _frame = CGRect(x: gap, y: authorizationY, width: infoViewW, height: infoViewH)
        self.authorizationView = InfoView(frame: _frame)
        self.authorizationView.backgroundColor = UIColor(red: 71 / 255, green: 189 / 255, blue: 80 / 255, alpha: 1.0)
        self.authorizationView.layer.cornerRadius = 8.0
        self.authorizationView.label1.text = "authorization: "
        self.authorizationView.label2.text = "version: "
        self.authorizationView.label3.text = ""
        self.view.addSubview(self.authorizationView)
        
        _frame.origin.y += (infoViewH + gap)
        self.profileView = InfoView(frame: _frame)
        self.profileView.backgroundColor = UIColor(red: 106 / 255, green: 199 / 255, blue: 75 / 255, alpha: 1.0)
        self.profileView.layer.cornerRadius = 8.0
        self.profileView.label1.text = "age: "
        self.profileView.label2.text = "job: "
        self.profileView.label3.text = "name: "
        self.view.addSubview(self.profileView)
        
        _frame.origin.y += (infoViewH + gap)
        self.dataView = InfoView(frame: _frame)
        self.dataView.backgroundColor = UIColor(red: 193 / 255, green: 199 / 255, blue: 75 / 255, alpha: 1.0)
        self.dataView.layer.cornerRadius = 8.0
        self.dataView.label1.text = "price: "
        self.dataView.label2.text = "amount: "
        self.dataView.label3.text = "performance: "
        self.view.addSubview(self.dataView)
        
        //增加按兩下改變資料手勢
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didRecognizeDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        self.dataView.addGestureRecognizer(doubleTapRecognizer)
        
        self.authorizationView.transform = CGAffineTransform.init(translationX: -frameW, y: 0)
        self.profileView.transform = CGAffineTransform.init(translationX: -frameW, y: 0)
        self.dataView.transform = CGAffineTransform.init(translationX: -frameW, y: 0)
        
        self.loadingView = LoadingAnimatingView()
        self.loadingView.style = .gray
        self.view.addSubview(self.loadingView)
        
//        self.loadingView.start()
//        DispatchQueue.global(qos: .default).async {
//            for i in 0 ... 400000 {
//                print(i)
//            }
//            DispatchQueue.main.async {
//                self.loadingView.stop()
//            }
//        }
        
        let trickyButton = UIButton(frame: CGRect(x: 0, y: frameH - 30, width: frameW, height: 30))
        trickyButton.addTarget(self, action: #selector(self.onTrickyButtonAction), for: .touchUpInside)
        trickyButton.backgroundColor = UIColor.black
        self.view.addSubview(trickyButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.bringSubview(toFront: self.loadingView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.authorizationView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        })
        UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.profileView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        })
        UIView.animate(withDuration: 0.8, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.dataView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        })
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.6 * 1000.0 * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC), execute: {
            self.loadingView.start()
            UpdateManager.sharedInstance.getData {
                DispatchQueue.main.async {
                    self.loadingView.stop()
                    
                    self.authorizationView.label1.text! += "\(AuthorizationModel.shareInstance.authorization ?? false)"
                    self.authorizationView.label2.text! += AuthorizationModel.shareInstance.version ?? ""
                    
                    self.profileView.label1.text! += "\(ProfileModel.shareInstance.age ?? 0)"
                    self.profileView.label2.text! += ProfileModel.shareInstance.job ?? ""
                    self.profileView.label3.text! += ProfileModel.shareInstance.name ?? ""
                    
                    self.dataView.label1.text! += "\(DataModel.shareInstance.price ?? 0)"
                    self.dataView.label2.text! += "\(DataModel.shareInstance.amount ?? 0)"
                    self.dataView.label3.text! += "\(DataModel.shareInstance.performance ?? 0)"
                }  
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - selector
    func didRecognizeDoubleTap() {
        print(#function)
        let popVC = PopVC()
        popVC.stepperValue = Double(DataModel.shareInstance.amount ?? 0)
        popVC.delegate = self
        //用pop方式跳出
        popVC.modalPresentationStyle = .popover
        popVC.preferredContentSize = CGSize(width: 10 + 94 + 10 + 42 + 10, height: 10 + 29 + 10)
        popVC.popoverPresentationController?.permittedArrowDirections = .up
        popVC.popoverPresentationController?.backgroundColor = UIColor.white
        popVC.popoverPresentationController?.delegate = self
        popVC.popoverPresentationController?.sourceView = self.dataView
        popVC.popoverPresentationController?.sourceRect = self.dataView.bounds
        self.present(popVC, animated: true, completion: {

        })
    }

    func onTrickyButtonAction() {
        _ = self.navigationController?.popViewController(animated: false)
    }

}

extension InfoVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
}

extension InfoVC: PopVCDelegate {
    
    func popVC(didSelect stepperValue: Int) {
        DataModel.shareInstance.amount = stepperValue
        DataModel.shareInstance.performance = (DataModel.shareInstance.price ?? 0) * stepperValue
        self.dataView.label2.text = "amount: " + "\(DataModel.shareInstance.amount ?? 0)"
        self.dataView.label3.text = "performance: " + "\(DataModel.shareInstance.performance ?? 0)"
    }
    
}
