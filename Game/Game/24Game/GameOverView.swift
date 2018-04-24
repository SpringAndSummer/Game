//
//  GameOverView.swift
//  Game
//
//  Created by Spring on 2018/4/18.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit

typealias endBtnBlock = ()->()
typealias resetBtnBlock = ()->()

class GameOverView: UIView {
    
    var bgView:UIView!
    var pinkView:UIView!
    var blueView:UIView!
    var tip:UILabel!
    var endBtn:UIButton!
    var resetBtn:UIButton!
    
    var endBlock:endBtnBlock?
    var resetBlock:resetBtnBlock?
    
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
        self.tip.font = UIFont.systemFont(ofSize: 30)
        self.tip.textAlignment = .center
        self.tip.text = "Game Over"
        self.tip.textColor = d4Color
        self.blueView.addSubview(self.tip)
        
        self.endBtn = UIButton()
        self.endBtn.setTitleColor(d4Color, for: .normal)
        self.endBtn.backgroundColor = blueColor
        self.endBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.endBtn.layer.cornerRadius = 3
        self.endBtn.clipsToBounds = true
        self.endBtn.addTarget(self, action: #selector(noBtnClick), for: .touchUpInside)
        self.endBtn.setTitle("End", for: .normal)
        self.pinkView.addSubview(self.endBtn)
        
        self.resetBtn = UIButton()
        self.resetBtn.setTitleColor(d4Color, for: .normal)
        self.resetBtn.backgroundColor = blueColor
        self.resetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.resetBtn.layer.cornerRadius = 3
        self.resetBtn.clipsToBounds = true
        self.resetBtn.addTarget(self, action: #selector(okBtnClick), for: .touchUpInside)
        self.resetBtn.setTitle("Again", for: .normal)
        self.pinkView.addSubview(self.resetBtn)
    }
    
    @objc func noBtnClick() -> Void {
        if((self.endBlock) != nil){
            self.endBlock!()
        }
    }
    @objc func okBtnClick() -> Void {
        if((self.resetBlock) != nil){
            self.resetBlock!()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgView.frame = CGRect.init(x: 0, y: 0, width: 250, height: 140)
        self.bgView.center = self.center
        
        self.blueView.frame = CGRect.init(x: 0, y: 0, width: self.bgView.width, height: self.bgView.height * 0.5)
        self.pinkView.frame = CGRect.init(x: 0, y: self.blueView.bottom, width: self.bgView.width, height: self.bgView.height * 0.5)
        
        self.tip.frame = self.blueView.bounds
        
        let btnWidth = self.bgView.width * 0.5 * 0.5
        let btnHeight = self.pinkView.height * 0.5
        self.endBtn.frame = CGRect.init(x: btnWidth * 0.5 , y: btnHeight * 0.5, width: btnWidth, height: btnHeight)
        self.resetBtn.frame = CGRect.init(x: self.bgView.width * 0.5 + btnWidth * 0.5 , y: btnHeight * 0.5, width: btnWidth, height: btnHeight)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
