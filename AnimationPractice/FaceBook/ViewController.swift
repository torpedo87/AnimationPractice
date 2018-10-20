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
    view.backgroundColor = .white
    
    let iconHeight: CGFloat = 38
    let images: [UIImage] = [UIImage(named: "crying")!, UIImage(named: "lol")!,
                             UIImage(named: "surprised")!, UIImage(named: "disappointed")!,
                             UIImage(named: "sad")!, UIImage(named: "happy")!]
    let arrangedSubviews = images.map({ img -> UIImageView in
      let imgView = UIImageView()
      imgView.isUserInteractionEnabled = true
      imgView.image = img
      imgView.layer.cornerRadius = iconHeight / 2
      return imgView
    })
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.distribution = .fillEqually
    
    let padding: CGFloat = 6
    stackView.spacing = padding
    stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    stackView.isLayoutMarginsRelativeArrangement = true
    
    let numberOfIcons = stackView.subviews.count
    let width: CGFloat = CGFloat(numberOfIcons) * iconHeight + padding * CGFloat(numberOfIcons + 1)
    
    view.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
    view.layer.cornerRadius = view.frame.height / 2
    stackView.frame = view.frame
    view.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
    view.layer.shadowRadius = 8
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: 0, height: 4)
    
    view.addSubview(stackView)
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Like"
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
      handleGestureBegan(gesture: gesture)
      
    } else if gesture.state == .ended {
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 1,
                     initialSpringVelocity: 1,
                     options: .curveEaseOut,
                     animations: {
                      let stackView = self.containerView.subviews.first
                      stackView?.subviews.forEach({ imgView in
                        imgView.transform = CGAffineTransform.identity
                      })
                      self.containerView.transform = self.containerView.transform.translatedBy(x: 0, y: self.containerView.frame.height)
                      self.containerView.alpha = 0
                      },
                     completion: { _ in
        self.containerView.removeFromSuperview()
      })
      
    } else if gesture.state == .changed {
      handleGestureChanged(gesture: gesture)
    }
  }
  
  private func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
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
  }
  
  private func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
    let pressedLocation = gesture.location(in: self.containerView)
    let fixedYLocation = CGPoint(x: pressedLocation.x, y: containerView.frame.height / 2)
    print(fixedYLocation.y)
    let hitTestView = containerView.hitTest(fixedYLocation, with: nil)
    
    if hitTestView is UIImageView {
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                     initialSpringVelocity: 1, options: .curveEaseOut,
                     animations: {
                      let stackView = self.containerView.subviews.first
                      stackView?.subviews.forEach({ imgView in
                        imgView.transform = CGAffineTransform.identity
                      })
                      hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
      }, completion: nil)
    }
  }
  
  
}

