//
//  ViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 27/07/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .yellow
    view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
    return view
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
    setupLongGesture()
    
  }
  
  override var prefersStatusBarHidden: Bool { return true }
  
  func setupLongGesture() {
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
    view.addGestureRecognizer(longPress)
  }
  
  @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
    if gesture.state == .began {
      view.addSubview(containerView)
      let touchLocation = gesture.location(in: view)
      containerView.transform =
        CGAffineTransform(translationX: (UIScreen.main.bounds.width - containerView.bounds.width) / 2,
                                                  y: touchLocation.y)
      
      containerView.alpha = 0
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                     initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut,
                     animations: {
                      
        self.containerView.alpha = 1
        self.containerView.transform =
          CGAffineTransform(translationX: (UIScreen.main.bounds.width - self.containerView.bounds.width) / 2,
                            y: touchLocation.y - self.containerView.bounds.height)
      }, completion: nil)
      
    } else if gesture.state == .ended {
      containerView.removeFromSuperview()
    }
  }
}

