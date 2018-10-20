//
//  CurvedViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 11/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class CurvedViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let curvedView = CurvedView.init(frame: view.frame)
    curvedView.backgroundColor = .green
    view.addSubview(curvedView)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
    view.addGestureRecognizer(tap)
  }
  
  @objc func handleTap(gesture: UITapGestureRecognizer) {
    (0...10).forEach { _ in
      generateAnimatedViews()
    }
  }
  
  func generateAnimatedViews() {
    
    let imgView = UIImageView(image: UIImage(named: "like"))
    imgView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.duration = 2 + drand48() * 3
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.isRemovedOnCompletion = true
    animation.path = CurvedView.customPath().cgPath
    animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
    
    imgView.layer.add(animation, forKey: nil)
    view.addSubview(imgView)
  }
  
}
