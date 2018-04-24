//
//  Game2ViewController.swift
//  Game
//
//  Created by Spring on 2018/4/15.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit

class Game24ViewController: BaseViewController {
    var playView1:PlayView!
    var playView2:PlayView!
    
    var resultView1:ResultView!
    var resultView2:ResultView!
    
    var args:[[String]]!
    var index:Int!
    
    var score1:Int!   //分数1
    var score2:Int!   //分数2
    var skimView:SkimView!
    var gameOverView:GameOverView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.score1 = 0
        self.score2 = 0
        
        weak var weakeSelf = self
        //玩家1界面
        self.playView1 = PlayView.init(frame: CGRect.init(x: 0, y: ScreenHeight * 0.5, width: ScreenWidth, height: ScreenHeight * 0.5))
        self.playView1.block = {
            weakeSelf?.score1 = (weakeSelf?.score1)! + 1
            if((weakeSelf?.score1)! >= 3){
                let showTitle = String.init(format: "You Win", (weakeSelf?.score1)!,(weakeSelf?.score2)!)
                weakeSelf?.resultView1.showTitle = showTitle
            }else{
                let showTitle = String.init(format: "Score %zd:%zd", (weakeSelf?.score1)!,(weakeSelf?.score2)!)
                weakeSelf?.resultView1.showTitle = showTitle
            }
            weakeSelf?.resultView1.isHidden = false
        }
        let theme1:Theme = Theme()
        theme1.color1 = pinColor
        theme1.color2 = blueColor
        self.playView1.theme = theme1
        self.view.addSubview(self.playView1)
        
        //玩家2界面
        self.playView2 = PlayView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.5))
        self.playView2.block = {
            weakeSelf?.score2 = (weakeSelf?.score2)! + 1
            if((weakeSelf?.score2)! >= 3){
                let showTitle = String.init(format: "You Win", (weakeSelf?.score2)!,(weakeSelf?.score1)!)
                weakeSelf?.resultView2.showTitle = showTitle
            }else{
                let showTitle = String.init(format: "Score %zd:%zd", (weakeSelf?.score2)!,(weakeSelf?.score1)!)
                weakeSelf?.resultView2.showTitle = showTitle
            }
            weakeSelf?.resultView2.isHidden = false
        }
        let theme2:Theme = Theme()
        theme2.color1 = blueColor
        theme2.color2 = pinColor
        self.playView2.theme = theme2
        self.playView2.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.view.addSubview(self.playView2)
        
        let back = UIButton.init(frame: CGRect.init(x: 0, y: (ScreenHeight * 0.5 - 15), width: 50, height: 30))
        back.layer.cornerRadius = 3
        back.clipsToBounds = true
        back.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        back.setTitle("Back", for: .normal)
        back.backgroundColor = UIColorFromRGB(rgbValue: 0x48D1CC, A: 1)
        back.setTitleColor(d4Color, for: .normal)
        self.view.addSubview(back)
        
        let pass = UIButton.init(frame: CGRect.init(x: ScreenWidth - 50, y: (ScreenHeight * 0.5 - 15), width: 50, height: 30))
        pass.layer.cornerRadius = 3
        pass.clipsToBounds = true
        pass.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        pass.setTitle("Pass", for: .normal)
        pass.backgroundColor = UIColorFromRGB(rgbValue: 0x48D1CC, A: 1)
        pass.setTitleColor(d4Color, for: .normal)
        self.view.addSubview(pass)
        self.args = [
                     ["6", "6" , "4", "6"],
                     ["3", "4" , "4", "3"],
                     ["7", "1" , "10", "6"],
                     ["8", "4" , "2", "6"],
                     ["9", "8" , "3", "1"],
                     ["1", "2" , "3", "4"],
                     ["6", "2" , "3", "6"],
                     ["2", "7" , "1", "3"],
                     ["3", "2" , "10", "8"],
                     ["5", "1" , "5", "1"],
                     ["5", "3" , "9", "2"],
                     ["10", "10" , "8", "4"],
                     ["7", "3" , "5", "2"],
                     ["2", "6" , "2", "1"],
                     ["5", "5" , "7", "6"],
                     ["4", "9" , "8", "4"],
                     ["3", "3" , "3", "3"],
                     ["8", "7" , "8", "1"],
                     ["5", "9" , "5", "2"],
                     ["7", "4" , "7", "3"]
                  ]
        self.index = (Int)(arc4random()) % self.args.count
        self.passClick()
        
        //玩家1答题正确回调
        self.resultView1 = ResultView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.resultView1.isHidden = true
        self.resultView1.theme = theme1

        self.resultView1.block = {
            weakeSelf?.resultView1.isHidden = true
            weakeSelf?.passClick()
            weakeSelf?.check()
        }
        self.resultView1.theme = theme1
        self.view.addSubview(self.resultView1)
        
        //玩家2答题正确回调
        self.resultView2 = ResultView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.resultView2.theme = theme2
        self.resultView2.isHidden = true
        self.resultView2.block = {
            weakeSelf?.resultView2.isHidden = true
            weakeSelf?.passClick()
            weakeSelf?.check()
        }
        self.resultView2.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.view.addSubview(self.resultView2)
        
        self.skimView = SkimView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.skimView.isHidden = true
        self.skimView.okBlock = {
            weakeSelf?.skimView.isHidden = true
            weakeSelf?.passClick()
        }
        self.skimView.noBlock = {
            weakeSelf?.skimView.isHidden = true
        }
        self.view.addSubview(self.skimView)
        
        self.gameOverView = GameOverView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.gameOverView.isHidden = true
        self.gameOverView.endBlock = {
            weakeSelf?.gameOverView.isHidden = true
            self.navigationController?.popViewController(animated: true)
        }
        self.gameOverView.resetBlock = {
            weakeSelf?.gameOverView.isHidden = true
            weakeSelf?.score1 = 0
            weakeSelf?.score2 = 0
            weakeSelf?.passClick()
        }
        self.view.addSubview(self.gameOverView)
    
    }
    func check() -> Void {
        if(self.score1 >= 3 || self.score2 >= 3){
            print("Game Over")
            print("\(self.score1)")
            print("\(self.score2)")
//            self.navigationController?.popViewController(animated: true)
            self.gameOverView.isHidden = false
        }
    }
    func createQuestion(arg:[String]) -> Void {
        let question = Question()
        question.num1 = arg[0]
        question.num2 = arg[1]
        question.num3 = arg[2]
        question.num4 = arg[3]
        self.playView2.question = question
        self.playView1.question = question
    }
    @objc func backClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func passClick() -> Void {
        self.index = self.index + 1
        let index = (self.index + self.args.count) % self.args.count
        self.createQuestion(arg: self.args[index])
    }
    @objc func nextClick() -> Void {
        self.skimView.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
