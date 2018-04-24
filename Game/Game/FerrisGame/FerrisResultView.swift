//
//  FerrisResultView.swift
//  Game
//
//  Created by Spring on 2018/4/18.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit
typealias FerrisResultViewBlock = () -> ()

class FerrisResultView: UIView {

    var backView:UIView!
    var tip:UILabel!
    var nextBtn:UIButton!
    var nextBlock:FerrisResultViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.backView = UIView.init()
        self.backView.layer.cornerRadius = 10
        self.backView.clipsToBounds = true
        self.backView.backgroundColor = pinColor
        self.addSubview(self.backView)
        
        self.tip = UILabel.init()
        self.tip.backgroundColor = pinColor
        self.tip.textAlignment = .center
        self.tip.font = UIFont.systemFont(ofSize: 30)
        self.tip.text = "Boom !"
        self.backView.addSubview(self.tip)
        
        self.nextBtn = UIButton.init()
        self.nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        self.nextBtn.setTitleColor(UIColor.black, for: .normal)
        self.nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        self.nextBtn.setTitle("Continue", for: .normal)
        self.nextBtn.backgroundColor = blueColor
        self.backView.addSubview(self.nextBtn)
    }
    
    @objc func nextBtnClick() ->Void{
        if(self.nextBlock != nil){
            self.nextBlock!()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let backWidth = 200
        let backHeight = 120
        
        self.backView.frame = CGRect.init(x: 0, y: 0, width: backWidth, height: backHeight)
        self.backView.center = self.center
        
        self.tip.frame = CGRect.init(x: 0, y: 0, width: self.backView.width, height: self.backView.height * 0.5)
        self.nextBtn.frame = CGRect.init(x: 0, y: self.tip.bottom, width: self.backView.width, height: self.backView.height * 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
