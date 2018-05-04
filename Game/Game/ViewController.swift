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
        
        let bgImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        bgImage.contentMode = .scaleAspectFill
        bgImage.clipsToBounds = true
        bgImage.image = UIImage.init(named: "bg.jpeg")
        self.view.addSubview(bgImage)
        
        let icon = UIImageView.init(frame: CGRect.init(x: (ScreenWidth - 150) * 0.5, y: ScreenHeight * 0.5 - 170, width: 150, height: 153))
        icon.image = UIImage.init(named: "logoIcon")
        self.view.addSubview(icon)
        
        let beginBtn = UIButton.init(frame: CGRect.init(x: (ScreenWidth - 100) * 0.5, y: icon.bottom + 40, width: 100, height: 104))
        beginBtn.addTarget(self, action: #selector(beginBtnClick), for: .touchUpInside)
        beginBtn.setImage(UIImage.init(named: "begin"), for: .normal)
        self.view.addSubview(beginBtn)
        beginBtn.center.x = icon.center.x
        
    }

    @objc func beginBtnClick() -> Void {
        let chooseVc = ChoseGameViewController()
        self.navigationController?.pushViewController(chooseVc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

