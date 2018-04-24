//
//  Const.swift
//  Game
//
//  Created by Spring on 2018/4/15.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import Foundation
import UIKit

//16进制转化颜色
func UIColorFromRGB(rgbValue:Int,A:CGFloat) -> UIColor {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: A)
}

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let pinColor = UIColorFromRGB(rgbValue: 0xFFC9BE, A: 1)
let blueColor = UIColorFromRGB(rgbValue: 0xB0E5FE, A: 1)
let d4Color = UIColorFromRGB(rgbValue: 0x4D4D4D, A: 1)    //按钮的颜色

let animationDuration = 0.06
//字体创建
func fonts(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

//等比例适配
func realValue6(value:CGFloat) -> CGFloat {
    return value / 375.0 * ScreenWidth
}

