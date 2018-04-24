//
//  CALayer+Category.swift
//  Game
//
//  Created by Spring on 2018/4/17.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import Foundation
import UIKit

extension CALayer
{
    func convertPointWhenRotatingWithBenchmarkPoint(point:CGPoint,radius:CGFloat) -> CGPoint {
        let rotationAngle:CGFloat = (self.presentation()?.transformRotationAngle())!
        return CGPoint.init(x: point.x + CGFloat(sinf(Float(rotationAngle))) * radius, y: point.y - radius + CGFloat(cosf(Float(rotationAngle))) * radius)
    }
    
    func convertPointWhenRotatingWithBenchmarkPoint2(point2:CGPoint,radius2:CGFloat) -> CGPoint {
        let rotationAngle:CGFloat = (self.presentation()?.transformRotationAngle())!
        return CGPoint.init(x: point2.x - CGFloat(sinf(Float(rotationAngle))) * radius2, y: point2.y - radius2 - CGFloat(cosf(Float(rotationAngle))) * radius2)
    }
    
    func transformRotationAngle() -> CGFloat {
        var degreeAngle:CGFloat = -CGFloat(atan2f(Float(self.presentation()!.transform.m21), Float(self.presentation()!.transform.m22)))
        if (degreeAngle < 0.0) {
            degreeAngle = degreeAngle + (CGFloat)(2.0 * Double.pi)
        }
        return degreeAngle;
    }
    
    ///暂停动画
    func pauseAnimation() {
        //取出当前时间,转成动画暂停的时间
        let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        //设置动画运行速度为0
        self.speed = 0.0;
        //设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
        self.timeOffset = pausedTime
    }
    ///恢复动画
    func resumeAnimation() {
        //获取暂停的时间差
        let pausedTime = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        //用现在的时间减去时间差,就是之前暂停的时间,从之前暂停的时间开始动画
        let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}
