//
//  ViewController.swift
//  Game
//
//  Created by Spring on 2018/4/15.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = blueColor
        
        let icon = UIImageView.init(frame: CGRect.init(x: (ScreenWidth - 200) * 0.5, y: ScreenHeight * 0.5 - 150, width: 200, height: 180))
        icon.image = UIImage.init(named: "star")
        self.view.addSubview(icon)
        
        let beginBtn = UIButton.init(frame: CGRect.init(x: ScreenWidth * 0.5 - 100 - 10, y: icon.bottom + 30, width: 100, height: 100))
        beginBtn.addTarget(self, action: #selector(beginBtnClick), for: .touchUpInside)
        beginBtn.setImage(UIImage.init(named: "begin"), for: .normal)
        self.view.addSubview(beginBtn)
        beginBtn.center.x = icon.center.x
        
//        let cupBtn = UIButton.init(frame: CGRect.init(x: ScreenWidth * 0.5 + 10, y: icon.bottom + 30, width: 60, height: 64.5))
//        cupBtn.setImage(UIImage.init(named: "cup"), for: .normal)
//        self.view.addSubview(cupBtn)
    }

    @objc func beginBtnClick() -> Void {
        let chooseVc = ChoseGameViewController()
        self.navigationController?.pushViewController(chooseVc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

