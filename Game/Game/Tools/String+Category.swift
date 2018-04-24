//
//  String+Category.swift
//  Game
//
//  Created by Spring on 2018/4/19.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString{
    class func createScoreString(score1:Int, score2:Int) -> NSAttributedString {
        let ats = NSMutableAttributedString()
        let score1Ats:NSAttributedString = NSAttributedString.init(string: String.init(format: "%zd", score1), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor:pinColor])
        let colonAts:NSAttributedString = NSAttributedString.init(string: " : ", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor:UIColor.white])
        let score2Ats:NSAttributedString = NSAttributedString.init(string: String.init(format: "%zd", score2), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor:blueColor])
        ats.append(score1Ats)
        ats.append(colonAts)
        ats.append(score2Ats)
        return ats
    }
}
