//
//  SkimView.swift
//  Game
//
//  Created by Spring on 2018/4/18.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit
typealias noBtnBlock = ()->()
typealias okBtnBlock = ()->()

class SkimView: UIView {

    var bgView:UIView!
    var pinkView:UIView!
    var blueView:UIView!
    var tip:UILabel!
    var okBtn:UIButton!
    var noBtn:UIButton!
    
    var noBlock:noBtnBlock?
    var okBlock:okBtnBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        self.bgView = UIView()
        self.bgView.layer.cornerRadius = 10
        self.bgView.clipsToBounds = true
        self.addSubview(self.bgView)
        
        self.blueView = UIView()
        self.blueView.backgroundColor = blueColor
        self.bgView.addSubview(self.blueView)
        
        self.pinkView = UIView()
        self.pinkView.backgroundColor = pinColor
        self.bgView.addSubview(self.pinkView)
        
        self.tip = UILabel()
        self.tip.textAlignment = .center
        self.tip.text = "Skip this question?"
        self.blueView.addSubview(self.tip)
        
        self.noBtn = UIButton()
        self.noBtn.backgroundColor = blueColor
        self.noBtn.setTitleColor(d4Color, for: .normal)
        self.noBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.noBtn.layer.cornerRadius = 3
        self.noBtn.clipsToBounds = true
        self.noBtn.addTarget(self, action: #selector(noBtnClick), for: .touchUpInside)
        self.noBtn.setTitle("NO", for: .normal)
        self.pinkView.addSubview(self.noBtn)
        
        self.okBtn = UIButton()
        self.okBtn.setTitleColor(d4Color, for: .normal)
        self.okBtn.backgroundColor = blueColor
        self.okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.okBtn.layer.cornerRadius = 3
        self.okBtn.clipsToBounds = true
        self.okBtn.addTarget(self, action: #selector(okBtnClick), for: .touchUpInside)
        self.okBtn.setTitle("YES", for: .normal)
        self.pinkView.addSubview(self.okBtn)
    }
    
    @objc func noBtnClick() -> Void {
        if((self.noBlock) != nil){
            self.noBlock!()
        }
    }
    
    @objc func okBtnClick() -> Void {
        if((self.okBlock) != nil){
            self.okBlock!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgView.frame = CGRect.init(x: 0, y: 0, width: 200, height: 120)
        self.bgView.center = self.center
        
        self.blueView.frame = CGRect.init(x: 0, y: 0, width: self.bgView.width, height: self.bgView.height * 0.5)
        self.pinkView.frame = CGRect.init(x: 0, y: self.blueView.bottom, width: self.bgView.width, height: self.bgView.height * 0.5)

        self.tip.frame = self.blueView.bounds
        
        let btnWidth = self.bgView.width * 0.5 * 0.5
        let btnHeight = self.pinkView.height * 0.5
        self.noBtn.frame = CGRect.init(x: btnWidth * 0.5 , y: btnHeight * 0.5, width: btnWidth, height: btnHeight)
        self.okBtn.frame = CGRect.init(x: self.bgView.width * 0.5 + btnWidth * 0.5 , y: btnHeight * 0.5, width: btnWidth, height: btnHeight)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
