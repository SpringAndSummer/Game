//
//  ResultView.swift
//  Game
//
//  Created by Spring on 2018/4/16.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit
typealias startBlock = ()->()
class ResultView: UIView {
    var block:startBlock?
    var bgView:UIView!
    var tip:UILabel!
    var score:UILabel!
    var start:UILabel!
    var showTitle:String!{
        didSet{
            self.score.text = showTitle
            self.setNeedsLayout()
        }
    }
    var theme:Theme!{
        didSet{
          self.bgView.backgroundColor = theme.color1
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        self.bgView = UIView.init()
        self.addSubview(self.bgView)
        
        self.tip = UILabel.init()
        self.tip.textColor = d4Color
        self.tip.textAlignment = .center
        self.tip.text = "Correct !"
        self.tip.font = UIFont.systemFont(ofSize: 40)
        self.bgView.addSubview(self.tip)
        
        self.score = UILabel.init()
        self.score.textColor = d4Color
        self.score.text = "Score"
        self.score.textAlignment = .center
        self.score.font = UIFont.systemFont(ofSize: 30)
        self.bgView.addSubview(self.score)
        
        self.start = UILabel.init()
        self.start.textColor = d4Color
        self.start.textAlignment = .center
        self.start.font = UIFont.systemFont(ofSize: 16)
        self.start.text = "Click to continue"
        self.bgView.addSubview(self.start)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        self.bgView.addGestureRecognizer(tap)
    }
    
    @objc func tapClick() -> Void {
        if((self.block) != nil){
            self.block!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bgView.frame = CGRect.init(x: 0, y: self.height * 0.5, width: self.width, height: self.height * 0.5)
        
        self.tip.sizeToFit()
        self.tip.frame = CGRect.init(x: 0, y: (self.bgView.height - self.tip.height) * 0.5 - 20, width: self.width, height: self.tip.height)
        
        self.score.sizeToFit()
        self.score.frame = CGRect.init(x: 0, y: self.tip.top - self.score.height - 20, width: self.bgView.width, height: self.score.height)
        
        self.start.sizeToFit()
        self.start.frame = CGRect.init(x: 0, y: self.tip.bottom + 20, width: self.bgView.width, height: self.start.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
