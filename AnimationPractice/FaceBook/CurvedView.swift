//
//  CurvedView.swift
//  AnimationPractice
//
//  Created by junwoo on 11/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class CurvedView: UIView {
  
  override func draw(_ rect: CGRect) {
    
    let path = CurvedView.customPath()
    path.lineWidth = 3
    path.stroke()
  }
  
  static func customPath() -> UIBezierPath {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let path = UIBezierPath()
    let startPoint = CGPoint(x: 0, y: 200)
    let endPoint = CGPoint(x: screenWidth, y: 400)
    path.move(to: startPoint)
    
    let randomY = CGFloat(200 + drand48() * 300)
    let controlPoint1 = CGPoint(x: screenWidth / 3, y: 100 - randomY)
    let controlPoint2 = CGPoint(x: screenWidth * 2 / 3, y: 400 + randomY)
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    return path
  }
}
