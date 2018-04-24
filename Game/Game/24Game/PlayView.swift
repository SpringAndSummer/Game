//
//  PlayView.swift
//  24Game
//
//  Created by Spring on 2018/4/15.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit
typealias nextBlock = () -> ()
class PlayView: UIView {

    var num1:UILabel!
    var num2:UILabel!
    var num3:UILabel!
    var num4:UILabel!
    
    var opAdd:UILabel!
    var opSub:UILabel!
    var opMul:UILabel!
    var opDev:UILabel!
    var okBrn:UIButton!
    var resetBtn:UIButton!
    var origal:CGPoint!
    
    var ex1:UILabel!
    var ex2:UILabel!
    var ex3:UILabel!
    var ex4:UILabel!
    var ex5:UILabel!
    var ex6:UILabel!
    var ex7:UILabel!

    var tip:UILabel!
    
    var block:nextBlock?
    var dic:[String:String]!
    
    var theme:Theme!{
        didSet{
            self.backgroundColor = theme.color1
            self.okBrn.setTitleColor(d4Color, for: .normal)
            self.okBrn.layer.borderColor = theme.color2.cgColor
            self.resetBtn.setTitleColor(d4Color, for: .normal)
            self.resetBtn.layer.borderColor = theme.color2.cgColor
            
            self.num1.layer.borderColor = theme.color2.cgColor
            self.num2.layer.borderColor = theme.color2.cgColor
            self.num3.layer.borderColor = theme.color2.cgColor
            self.num4.layer.borderColor = theme.color2.cgColor
            self.opAdd.layer.borderColor = theme.color2.cgColor
            self.opSub.layer.borderColor = theme.color2.cgColor
            self.opMul.layer.borderColor = theme.color2.cgColor
            self.opDev.layer.borderColor = theme.color2.cgColor
            
            self.ex1.layer.borderColor = theme.color2.cgColor
            self.ex2.layer.borderColor = theme.color2.cgColor
            self.ex3.layer.borderColor = theme.color2.cgColor
            self.ex4.layer.borderColor = theme.color2.cgColor
            self.ex5.layer.borderColor = theme.color2.cgColor
            self.ex6.layer.borderColor = theme.color2.cgColor
            self.ex7.layer.borderColor = theme.color2.cgColor
        }
    }
    var question:Question!{
        didSet{          
            self.num1.text = question.num1
            self.num2.text = question.num2
            self.num3.text = question.num3
            self.num4.text = question.num4
            self.resetAction();
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.isExclusiveTouch = true
        self.ex1 = self.createEx()
        self.ex2 = self.createEx()
        self.ex3 = self.createEx()
        self.ex4 = self.createEx()
        self.ex5 = self.createEx()
        self.ex6 = self.createEx()
        self.ex7 = self.createEx()
        
        self.addSubview(self.ex1)
        self.addSubview(self.ex2)
        self.addSubview(self.ex3)
        self.addSubview(self.ex4)
        self.addSubview(self.ex5)
        self.addSubview(self.ex6)
        self.addSubview(self.ex7)
        
        self.num1 = self.createLbael(name: "1")
        self.num1.tag = 1
        self.num2 = self.createLbael(name: "2")
        self.num2.tag = 2
        self.num3 = self.createLbael(name: "3")
        self.num3.tag = 3
        self.num4 = self.createLbael(name: "4")
        self.num4.tag = 4
        
        self.dic = ["one":"0","two":"0","three":"0","four":"0"]
        
        self.opAdd = self.createLbael(name: "+")
        self.opSub = self.createLbael(name: "-")
        self.opMul = self.createLbael(name: "x")
        self.opDev = self.createLbael(name: "/")
        
        self.okBrn = UIButton.init(type: .system)
        self.okBrn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.okBrn.backgroundColor = UIColor.white
        self.okBrn.layer.cornerRadius = 4
        self.okBrn.layer.borderWidth = 2
        self.okBrn.layer.borderColor = UIColor.red.cgColor
        self.okBrn.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        self.okBrn.setTitle("OK", for: .normal)
        self.addSubview(self.okBrn)
        
        self.resetBtn = UIButton.init(type: .system)
        self.resetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.resetBtn.backgroundColor = UIColor.white
        self.resetBtn.layer.cornerRadius = 4
        self.resetBtn.layer.borderWidth = 2
        self.resetBtn.layer.borderColor = UIColor.red.cgColor
        self.resetBtn.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        self.resetBtn.setTitle("Reset", for: .normal)
        self.addSubview(self.resetBtn)
        
        self.addSubview(self.opAdd)
        self.addSubview(self.opSub)
        self.addSubview(self.opMul)
        self.addSubview(self.opDev)
        
        self.addSubview(self.num1)
        self.addSubview(self.num2)
        self.addSubview(self.num3)
        self.addSubview(self.num4)
    
        self.tip = UILabel()
        self.tip.layer.cornerRadius = realValue6(value: 5.0)
        self.tip.clipsToBounds = true
        self.tip.text = "error!"
        self.tip.textColor = UIColor.white
        self.tip.font = UIFont.systemFont(ofSize: 18)
        self.tip.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        self.tip.textAlignment = .center
        self.tip.alpha = 0
        self.addSubview(self.tip)
        
        self.origal = CGPoint.zero
    }
    @objc func okAction() -> Void {
        
        var args:[String] = [String]()
        if let ex1Str = self.ex1.text{
            args.append(ex1Str)
        }
        if let ex1Str = self.ex2.text{
            args.append(ex1Str)
        }
        if let ex1Str = self.ex3.text{
            args.append(ex1Str)
        }
        if let ex1Str = self.ex4.text{
            args.append(ex1Str)
        }
        if let ex1Str = self.ex5.text{
            args.append(ex1Str)
        }
        if let ex1Str = self.ex6.text{
            args.append(ex1Str)
        }
        if let ex1Str = self.ex7.text{
            args.append(ex1Str)
        }
        if(args.count == 7){
            if(self.check(args: args)){
                print("输入表达式合法")
                if(self.calc(args: args) == 24){
                    print("Bingo")
                    self.clear()
                    if(self.block != nil){
                        self.block!()
                    }
                }else{
                    print("答案错误")
                    self.showError()
                }
            }else{
                print("输入表达式不合法")
                self.showError()
            }
        }else{
            print("输入表达式不完整")
            self.showError()
        }
    }
    @objc func resetAction() -> Void {
        self.dic = ["one":"0","two":"0","three":"0","four":"0"]
        self.clear()
        //恢复题库
        self.num1.isHidden = false
        self.num2.isHidden = false
        self.num3.isHidden = false
        self.num4.isHidden = false
        self.setNeedsLayout()
    }
    func createLbael(name:String) -> UILabel {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 20)
        label.isUserInteractionEnabled = true
        label.layer.cornerRadius = realValue6(value: 30.0)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.clipsToBounds = true
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.text = name
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(sender:)))
        label.addGestureRecognizer(pan)
        return label
    }
    func createEx() -> UILabel {
        let label = UILabel.init()
        label.layer.cornerRadius = realValue6(value: 10.0)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.clipsToBounds = true
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        return label
    }
    @objc func panAction(sender:UIPanGestureRecognizer) -> Void {
        if(sender.state == .began){
            origal = (sender.view?.center)!
        }
        let p = sender.translation(in: sender.view)
        sender.view?.center = CGPoint.init(x: (sender.view?.center.x)! + p.x, y: (sender.view?.center.y)! + p.y)
        sender.setTranslation(CGPoint.zero, in: self)
        if(sender.state == .ended){
            let label:UILabel = sender.view as! UILabel
            print("\(String(describing: label.text))")
            self.check(label: label)
        }
    }
    func check(label:UILabel) -> Void {
        let text = label.text
        let labelFrame = label.frame

        if(text == "+" || text == "-" || text == "x" || text == "/"){
            let ex2Frame = self.ex2.frame
            let ex4Frame = self.ex4.frame
            let ex6Frame = self.ex6.frame
            if(labelFrame.intersects(ex2Frame)){
                self.ex2.text = text
            }else if(labelFrame.intersects(ex4Frame)){
                self.ex4.text = text
            }else if(labelFrame.intersects(ex6Frame)){
                self.ex6.text = text
            }
            label.center = origal
        }else{
            let ex1Frame = self.ex1.frame
            let ex3Frame = self.ex3.frame
            let ex5Frame = self.ex5.frame
            let ex7Frame = self.ex7.frame
            if(labelFrame.intersects(ex1Frame)){
                self.ex1.text = text
                label.isHidden = true
                self.dealNumer(str: "one", tag: label.tag)
            }else if(labelFrame.intersects(ex3Frame)){
                self.ex3.text = text
                label.isHidden = true
                self.dealNumer(str: "two", tag: label.tag)
            }else if(labelFrame.intersects(ex5Frame)){
                self.ex5.text = text
                label.isHidden = true
                self.dealNumer(str: "three", tag: label.tag)
            }else if(labelFrame.intersects(ex7Frame)){
                self.ex7.text = text
                label.isHidden = true
                self.dealNumer(str: "four", tag: label.tag)
            }else{
                label.center = origal
            }
        }
    }
    func dealNumer(str:String,tag:Int) -> Void {
        let tmpAim:Int = Int(self.dic[str]!)!
        if(tmpAim != 0){
            if(tmpAim == 1){
                self.num1.isHidden = false
            }else if(tmpAim == 2){
                self.num2.isHidden = false
            }else if(tmpAim == 3){
                self.num3.isHidden = false
            }else if(tmpAim == 4){
                self.num4.isHidden = false
            }
        }
        let tag:String = String.init(format: "%zd", tag)
        self.dic[str] = tag
        self.setNeedsLayout()
    }
    func showError() -> Void {
        UIView.animate(withDuration: 1, animations: {
            self.tip.alpha = 1
        }) { (true) in
            self.tip.alpha = 0
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let top:CGFloat = realValue6(value: 30.0)
        let marginX:CGFloat = realValue6(value: 10.0)
        let marginY:CGFloat = realValue6(value: 10.0)
        let width:CGFloat = realValue6(value: 60.0)
        let left:CGFloat = (self.width - width * 4 - marginX * 3) * 0.5

        self.num1.frame = CGRect.init(x: left, y: top, width: width, height: width)
        self.num2.frame = CGRect.init(x: self.num1.right + marginX, y: top, width: width, height: width)
        self.num3.frame = CGRect.init(x: self.num2.right + marginX, y: top, width: width, height: width)
        self.num4.frame = CGRect.init(x: self.num3.right + marginX, y: top, width: width, height: width)

        self.opAdd.frame = CGRect.init(x: left, y: self.num1.bottom + marginY, width: width, height: width)
        self.opSub.frame = CGRect.init(x: self.opAdd.right + marginX, y: self.opAdd.top, width: width, height: width)
        self.opMul.frame = CGRect.init(x: self.opSub.right + marginX, y: self.opAdd.top, width: width, height: width)
        self.opDev.frame = CGRect.init(x: self.opMul.right + marginX, y: self.opAdd.top, width: width, height: width)
        
        self.resetBtn.frame = CGRect.init(x: (self.width - realValue6(value: 200.0)) * 0.5, y: self.opDev.bottom + realValue6(value: 30.0), width: realValue6(value: 90.0), height: realValue6(value: 40.0))
        self.okBrn.frame = CGRect.init(x: self.resetBtn.right + realValue6(value: 20.0), y: self.opDev.bottom + realValue6(value: 30.0), width: realValue6(value: 90.0), height: realValue6(value: 40.0))

        let exMaginX:CGFloat = 8.0
        let exMaginLeft:CGFloat = 10.0
        let exWidth:CGFloat = (self.width - exMaginLeft * 2 - exMaginX * 6) / 7.0
        let numHeight:CGFloat = realValue6(value: 50.0)
        let opHeight:CGFloat = realValue6(value: 30.0)
        let numTop:CGFloat = self.okBrn.bottom + realValue6(value: 30.0)
        let opTop:CGFloat = numTop + realValue6(value: 10.0)

        self.ex1.frame = CGRect.init(x: exMaginLeft, y:numTop , width: exWidth, height: numHeight)
        self.ex2.frame = CGRect.init(x: self.ex1.right + exMaginX, y: opTop, width: exWidth, height: opHeight)
        self.ex3.frame = CGRect.init(x: self.ex2.right + exMaginX, y: numTop, width: exWidth, height: numHeight)
        self.ex4.frame = CGRect.init(x: self.ex3.right + exMaginX, y: opTop, width: exWidth, height: opHeight)
        self.ex5.frame = CGRect.init(x: self.ex4.right + exMaginX, y: numTop, width: exWidth, height: numHeight)
        self.ex6.frame = CGRect.init(x: self.ex5.right + exMaginX, y: opTop, width: exWidth, height: opHeight)
        self.ex7.frame = CGRect.init(x: self.ex6.right + exMaginX, y: numTop, width: exWidth, height: numHeight)
        self.tip.frame = CGRect.init(x: (self.width - realValue6(value: 80.0)) * 0.5, y: (self.height - realValue6(value: 30.0)) * 0.5, width: realValue6(value: 80.0), height: realValue6(value: 30.0))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func clear() -> Void {
        self.ex1.text = nil;
        self.ex2.text = nil;
        self.ex3.text = nil;
        self.ex4.text = nil;
        self.ex5.text = nil;
        self.ex6.text = nil;
        self.ex7.text = nil;
    }
    func check(args:[String]) -> Bool {
        for (index,value) in args.enumerated(){
            if index % 2 == 0{
                if(!isInteger(string: value)){
                    return false
                }
            }else{
                if(value != "+" && value != "-" && value != "x" && value != "/"){
                    return false
                }
            }
        }
        return true
    }
    func isInteger(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    func calculate(arg1:String, arg2:String, operate:String) -> Int {
        switch operate {
        case "+":return Int(arg1)! + Int(arg2)!
        case "-":return Int(arg1)! - Int(arg2)!
        case "x":return Int(arg1)! * Int(arg2)!
        case "/":return Int(arg1)! / Int(arg2)!
        default: return 0
        }
    }
    var result = 0
    func calc(args:[String]) -> Int {
        if args.count == 1{
            return Int(args.first!)!
        }
        while args.count > 1 {
            if args.contains("x") || args.contains("/") || args.contains("%"){
                for (index,value) in args.enumerated(){
                    if value == "x" || value == "/" || value == "%"{
                        result = calculate(arg1: args[index - 1], arg2: args[index + 1], operate: value)
                        var tmpArgs = args
                        tmpArgs[index] = String(result)
                        tmpArgs.remove(at: index + 1)
                        tmpArgs.remove(at: index - 1)
                        return calc(args: tmpArgs)
                    }
                }
            }else{
                for (index,value) in args.enumerated(){
                    if value == "+" || value == "-"{
                        result = calculate(arg1: args[index - 1], arg2: args[index + 1], operate: value)
                        var tmpArgs = args
                        tmpArgs[index] = String(result)
                        tmpArgs.remove(at: index + 1)
                        tmpArgs.remove(at: index - 1)
                        return calc(args: tmpArgs)
                    }
                }
            }
        }
        return result
    }
}
