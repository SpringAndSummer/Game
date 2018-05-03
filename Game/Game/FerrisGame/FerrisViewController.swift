//
//  FerrisViewController.swift
//  Game
//
//  Created by Spring on 2018/4/16.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit

let kCentralAxisLayerWidth:CGFloat = ScreenWidth / 5.0
let kTopRoundRadius:CGFloat = 10.0
let kStrokeRoundRadius:CGFloat = 2.0 * kCentralAxisLayerWidth + kTopRoundRadius

class FerrisViewController: BaseViewController {
    var flagBlue:Bool!  //是否轮到蓝方
    var score1:Int!     //蓝方分数1
    var score2:Int!     //红方分数2

    var arrowStrokePath:UIBezierPath!
    
    var blueScoreLabel:UILabel!
    var pinkScoreLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrowStrokePath = self.createArrowStrokePath()
        self.view.addSubview(self.pinkView)
        self.view.addSubview(self.blueView)
        self.view.addSubview(self.back)
        
        self.blueScoreLabel = self.createScoreLabel()
        self.blueScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.pinkScoreLabel = self.createScoreLabel()
        self.view.addSubview(self.blueScoreLabel)
        self.view.addSubview(self.pinkScoreLabel)
        
        self.view.layer.addSublayer(self.centralAxisLayer)
        self.centralAxisLayer.add(self.rotation, forKey: "rotation")
        
        self.view.addSubview(self.showProcessView)
        self.view.addSubview(self.showProcessView2)
        self.view.addSubview(self.oddRoundsLabel)
        self.view.addSubview(self.oddRoundsLabel2)
        
        self.view.addSubview(self.stateBlue)
        self.view.addSubview(self.statePink)

        self.flagBlue = (arc4random() % 2 == 1) ? true : false
        self.score1 = 0
        self.score2 = 0
    
        self.view.addSubview(self.score)
        self.showScore()
        
        weak var weakeSelf = self
        self.ferrisResultView.nextBlock = {
            weakeSelf?.restartGame()
            weakeSelf?.ferrisResultView.isHidden = true
            weakeSelf?.flagBlue = (arc4random() % 2 == 1) ? true : false
            weakeSelf?.stateChane()
        }
        self.view.addSubview(self.ferrisResultView)
        
        self.ferrisGameOverView.endBlock = {
            weakeSelf?.navigationController?.popViewController(animated: true)
        }
        
        self.ferrisGameOverView.resetBlock = {
            weakeSelf?.score1 = 0
            weakeSelf?.score2 = 0
            weakeSelf?.showScore()
            weakeSelf?.flagBlue = (arc4random() % 2 == 1) ? true : false
            weakeSelf?.ferrisGameOverView.isHidden = true
            weakeSelf?.ferrisResultView.isHidden = true
            weakeSelf?.restartGame()
            weakeSelf?.stateChane()
        }
        self.view.addSubview(self.ferrisGameOverView)
        self.stateChane()
        self.layout()
    }
    
    @objc func backClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func check() -> Void {
        if(self.score1 >= 3 || self.score2 >= 3){
            print("Game Over")
            print("\(self.score1)")
            print("\(self.score2)")
            if(score1 >= 3){
                self.ferrisGameOverView.showTitle = "Red Win!"
            }else{
                self.ferrisGameOverView.showTitle = "Blue Win!"
            }
            self.ferrisResultView.isHidden = true
            self.ferrisGameOverView.isHidden = false
        }
    }
    
    func layout() -> Void {
        
        self.blueView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.5)
        self.pinkView.frame = CGRect.init(x: 0, y: ScreenHeight * 0.5, width: ScreenWidth, height: ScreenHeight * 0.5)
        
        self.back.frame = CGRect.init(x: 0, y: (ScreenHeight * 0.5 - 15), width: 50, height: 30)
        
        self.pinkScoreLabel.frame = CGRect.init(x: 0, y: ScreenHeight - 30, width: 30, height: 30)
        self.blueScoreLabel.frame = CGRect.init(x: ScreenWidth - 30, y: 0, width: 30, height: 30)
        
        //中间的圆盘
        self.centralAxisLayer.frame = CGRect.init(x: 0, y: 0, width: kCentralAxisLayerWidth, height: kCentralAxisLayerWidth)
        self.centralAxisLayer.position = self.view.center;
        
        //剩余的针数量
        self.oddRoundsLabel.frame = CGRect.init(x: 0, y: 0, width: 2.0 * kTopRoundRadius, height: 2.0 * kTopRoundRadius)
        self.oddRoundsLabel.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y + kCentralAxisLayerWidth / 2.0 + 3.0 / 2.0 * kCentralAxisLayerWidth + 7.0 * kTopRoundRadius)
        self.oddRoundsLabel.layer.cornerRadius = kTopRoundRadius;
        
        self.oddRoundsLabel2.frame = CGRect.init(x: 0, y: 0, width: 2.0 * kTopRoundRadius, height: 2.0 * kTopRoundRadius)
        self.oddRoundsLabel2.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y - (kCentralAxisLayerWidth / 2.0 + 3.0 / 2.0 * kCentralAxisLayerWidth + 7.0 * kTopRoundRadius))
        self.oddRoundsLabel2.layer.cornerRadius = kTopRoundRadius
        
        //扎针的一个假象,用来做动画
        self.showProcessView.frame = CGRect.init(x: 0, y: 0, width: 2.0 * kTopRoundRadius, height: 3.0 / 2.0 * kCentralAxisLayerWidth + 2.0 * kTopRoundRadius)
        self.showProcessView.center = CGPoint.init(x: self.view.center.x, y: self.oddRoundsLabel.center.y - 3.0 / 4.0 * kCentralAxisLayerWidth)
        
        self.showProcessView2.frame = CGRect.init(x: 0, y: 0, width: 2.0 * kTopRoundRadius, height: 3.0 / 2.0 * kCentralAxisLayerWidth + 2.0 * kTopRoundRadius)
        self.showProcessView2.center = CGPoint.init(x: self.view.center.x, y: self.oddRoundsLabel2.center.y - 3.0 / 4.0 * kCentralAxisLayerWidth)
        
        self.ferrisGameOverView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        
        self.statePink.frame = CGRect.init(x: ScreenWidth - 30, y: ScreenHeight - 30, width: 30, height: 30)
        self.stateBlue.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        
        self.score.frame = CGRect.init(x: 0, y: 0, width: kCentralAxisLayerWidth, height: kCentralAxisLayerWidth)
        self.score.center = self.view.center
        
        self.ferrisResultView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
    }
    
    lazy var pinkView: UIView = {
        () -> UIView in
        let pinView = UIView()
        pinView.backgroundColor = pinColor
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(pinkClick))
        pinView.addGestureRecognizer(tap)
        return pinView
    }()

    @objc func pinkClick() -> Void {
        if(self.flagBlue == false){
            return
        }
        self.flagBlue = false
        self.stateChane()
        UIView.animate(withDuration: animationDuration, animations: {
            self.showProcessView.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y + kCentralAxisLayerWidth / 2.0 + 3.0 / 4.0 * kCentralAxisLayerWidth + kTopRoundRadius)
            self.showProcessView.isHidden = false
        }) { (sussess) in
            if(sussess){
                self.showProcessView.isHidden = true
                self.showProcessView.center = CGPoint.init(x: self.oddRoundsLabel.center.x, y: self.oddRoundsLabel.center.y - 3.0 / 4.0 * kCentralAxisLayerWidth)
                
                let strokeStartPoint = self.centralAxisLayer.convertPointWhenRotatingWithBenchmarkPoint(point: CGPoint.init(x: kCentralAxisLayerWidth / 2.0, y: kCentralAxisLayerWidth), radius: kCentralAxisLayerWidth / 2.0)
                
                let strokeEndPoint = self.centralAxisLayer.convertPointWhenRotatingWithBenchmarkPoint(point: CGPoint.init(x: kCentralAxisLayerWidth / 2.0, y: kCentralAxisLayerWidth / 2.0 + kStrokeRoundRadius), radius: kStrokeRoundRadius)
                
                let strokeBezier = UIBezierPath()
                strokeBezier.move(to: strokeStartPoint)
                strokeBezier.addLine(to: strokeEndPoint)
                strokeBezier.move(to: strokeEndPoint)
                strokeBezier.addArc(withCenter: strokeEndPoint, radius: kTopRoundRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
                self.arrowStrokePath.append(strokeBezier)
                self.centralAxisLayer.path = self.arrowStrokePath.cgPath;
                if(self.isCrash(point: strokeEndPoint)){
                    self.score2 = self.score2 + 1
                    self.showScore()
                    self.check()
                    self.ferrisResultView.isHidden = false
                }
            }
        }
    }
    
    lazy var blueView: UIView = {
        () -> UIView in
        let blueView = UIView()
        blueView.isExclusiveTouch = true
        blueView.backgroundColor = blueColor
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(blueClick))
        blueView.addGestureRecognizer(tap)
        return blueView
    }()
    
    @objc func blueClick() -> Void {
        if(self.flagBlue == true){
            return
        }
        self.flagBlue = true
        self.stateChane()
        UIView.animate(withDuration: animationDuration, animations: {
            self.showProcessView2.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y - (kCentralAxisLayerWidth / 2.0 + 3.0 / 4.0 * kCentralAxisLayerWidth + kTopRoundRadius))
            self.showProcessView2.isHidden = false
        }) { (sussess) in
            if(sussess){
                self.showProcessView2.isHidden = true
                self.showProcessView2.center = CGPoint.init(x: self.oddRoundsLabel2.center.x, y: self.oddRoundsLabel2.center.y + 3.0 / 4.0 * kCentralAxisLayerWidth)
                let strokeStartPoint = self.centralAxisLayer.convertPointWhenRotatingWithBenchmarkPoint2(point2: CGPoint.init(x: kCentralAxisLayerWidth / 2.0, y: kCentralAxisLayerWidth), radius2: kCentralAxisLayerWidth / 2.0)
                let strokeEndPoint = self.centralAxisLayer.convertPointWhenRotatingWithBenchmarkPoint2(point2: CGPoint.init(x: kCentralAxisLayerWidth / 2.0, y: kCentralAxisLayerWidth / 2.0 + kStrokeRoundRadius), radius2: kStrokeRoundRadius)
                let strokeBezier = UIBezierPath()
                strokeBezier.move(to: strokeStartPoint)
                strokeBezier.addLine(to: strokeEndPoint)
                strokeBezier.move(to: strokeEndPoint)
                strokeBezier.addArc(withCenter: strokeEndPoint, radius: kTopRoundRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
                self.arrowStrokePath.append(strokeBezier)
                self.centralAxisLayer.path = self.arrowStrokePath.cgPath;
                if(self.isCrash(point: strokeEndPoint)){
                    self.score1 = self.score1 + 1
                    self.showScore()
                    self.check()
                    self.ferrisResultView.isHidden = false
                }
            }
        }
    }
    
    //检测是否碰撞
    func isCrash(point:CGPoint) -> Bool {
        for tmpPomit in self.strokePoints {
            let prePoint = tmpPomit.cgPointValue
            let dis = sqrt(pow(prePoint.x - point.x, 2) + pow(prePoint.y - point.y, 2))
            if(dis <= 2 * kTopRoundRadius + 1){
                self.centralAxisLayer.pauseAnimation()
                return true
            }
        }
        self.strokePoints.append(NSValue.init(cgPoint: point))
        return false
    }

    func restartGame() -> Void {
        self.arrowStrokePath = self.createArrowStrokePath()
        self.centralAxisLayer.path = nil
        self.strokePoints.removeAll()
        self.centralAxisLayer.path = self.arrowStrokePath.cgPath
        self.centralAxisLayer.resumeAnimation()
    }
    
    lazy var centralAxisLayer:CAShapeLayer = {
        let tmpLayer = CAShapeLayer()
        tmpLayer.backgroundColor = UIColor.black.cgColor
        tmpLayer.cornerRadius = kCentralAxisLayerWidth / 2.0
        tmpLayer.path = self.arrowStrokePath.cgPath
        tmpLayer.lineWidth = 2.0
        tmpLayer.strokeColor = UIColor.black.cgColor
        tmpLayer.fillColor = UIColor.black.cgColor
        return tmpLayer
    }()
    
    func createArrowStrokePath() -> UIBezierPath {
        let strokePath = UIBezierPath()
        return strokePath
    }
    
    lazy var strokePoints:[NSValue] = {
        let tmpStrokePoints = [NSValue]()
        return tmpStrokePoints
    }()
    
    //假针生成
    lazy var showProcessView:UIView = {
        let processView = UIView()
        processView.backgroundColor = UIColor.clear
        processView.isHidden = true
        
        let roundBottomView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 2.0 * kTopRoundRadius, height: 2.0 * kTopRoundRadius))
        roundBottomView.center = CGPoint.init(x: kTopRoundRadius, y: 3.0 / 2.0 * kCentralAxisLayerWidth + kTopRoundRadius)
        roundBottomView.layer.cornerRadius = kTopRoundRadius
        roundBottomView.clipsToBounds = true
        processView.addSubview(roundBottomView)
        
        let lineView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 2.0, height: 3.0 / 2.0 * kCentralAxisLayerWidth))
        lineView.center = CGPoint.init(x: kTopRoundRadius, y: 3.0 / 4.0 * kCentralAxisLayerWidth)
        lineView.backgroundColor = UIColor.black
        processView.addSubview(lineView)
        return processView
    }()
    
    lazy var showProcessView2:UIView = {
        let processView = UIView()
        processView.backgroundColor = UIColor.clear
        processView.isHidden = true
        
        let roundBottomView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 2.0 * kTopRoundRadius, height: 2.0 * kTopRoundRadius))
        roundBottomView.center = CGPoint.init(x: kTopRoundRadius, y: 3.0 / 2.0 * kCentralAxisLayerWidth + kTopRoundRadius)
        roundBottomView.layer.cornerRadius = kTopRoundRadius
        roundBottomView.clipsToBounds = true
        processView.addSubview(roundBottomView)
        
        let lineView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 2.0, height: 3.0 / 2.0 * kCentralAxisLayerWidth))
        lineView.center = CGPoint.init(x: kTopRoundRadius, y: 3.0 / 4.0 * kCentralAxisLayerWidth)
        lineView.backgroundColor = UIColor.black
        processView.addSubview(lineView)
        return processView
    }()
    
    lazy var rotation:CAKeyframeAnimation = {
        let tmpRotation = CAKeyframeAnimation.init(keyPath: "transform.rotation.z")
        tmpRotation.values = [0.0, (2.0 * Double.pi)]
        tmpRotation.duration = 7
        tmpRotation.isRemovedOnCompletion = false
        tmpRotation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        tmpRotation.fillMode = kCAFillModeForwards
        return tmpRotation
    }()
    
    lazy var oddRoundsLabel:UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = kTopRoundRadius;
        label.clipsToBounds = true
        label.backgroundColor = UIColor.black
        return label
    }()
    
    lazy var oddRoundsLabel2:UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = kTopRoundRadius;
        label.clipsToBounds = true
        label.backgroundColor = UIColor.black
        return label
    }()
    
    lazy var back:UIButton! = {
        let back = UIButton()
        back.layer.cornerRadius = 3
        back.clipsToBounds = true
        back.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        back.setTitle("Back", for: .normal)
        back.backgroundColor = UIColorFromRGB(rgbValue: 0x48D1CC, A: 1)
        back.setTitleColor(d4Color, for: .normal)
        return back
    }()
   
    lazy var ferrisGameOverView:FerrisGameOverView! = {
        let ferrisGameOverView = FerrisGameOverView()
        ferrisGameOverView.isHidden = true
        return ferrisGameOverView
    }()
    
    lazy var statePink:UIImageView! = {
        let statePink = UIImageView()
        statePink.backgroundColor = blueColor
        statePink.isHidden = true
        return statePink
    }()
    
    lazy var stateBlue:UIImageView! = {
        let stateBlue = UIImageView()
        stateBlue.backgroundColor = pinColor
        stateBlue.isHidden = true
        return stateBlue
    }()
    
    func stateChane() -> Void {
        if(flagBlue){
            self.stateBlue.isHidden = true
            self.statePink.isHidden = false
        }else{
            self.stateBlue.isHidden = false
            self.statePink.isHidden = true
        }
    }
    
    func createScoreLabel() -> UILabel {
        let label = UILabel()
        label.textColor = d4Color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    func showScore() -> Void {
        self.score.attributedText = NSAttributedString.createScoreString(score1: self.score1, score2: self.score2)
        self.pinkScoreLabel.text = String.init(format: "%zd", self.score1)
        self.blueScoreLabel.text = String.init(format: "%zd", self.score2)
    }
    
    lazy var score:UILabel! = {
        let score = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kCentralAxisLayerWidth, height: kCentralAxisLayerWidth))
        score.center = self.view.center
        score.textAlignment = .center
        score.textColor = UIColor.white
        return score
    }()
    
    lazy var ferrisResultView:FerrisResultView! = {
        let  ferrisResultView = FerrisResultView()
        ferrisResultView.isHidden = true
        return ferrisResultView
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
