//
//  ShimmerViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 20/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class ShimmerViewController: UIViewController {
  
  private lazy var darkTextLabel: UILabel = {
    let label = UILabel()
    label.text = "Shimmer"
    label.font = UIFont.systemFont(ofSize: 80)
    label.textColor = UIColor(white: 1, alpha: 0.2)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
    return label
  }()
  
  private lazy var shinyTextLabel: UILabel = {
    let label = UILabel()
    label.text = "Shimmer"
    label.font = UIFont.systemFont(ofSize: 80)
    label.textColor = .white
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
    return label
  }()
  
  private lazy var gradientLayer: CAGradientLayer = {
    let gradLayer = CAGradientLayer()
    gradLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
    gradLayer.locations = [0, 0.5, 1]
    gradLayer.frame = darkTextLabel.frame
    let angle = 45 * CGFloat.pi / 180
    gradLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
    return gradLayer
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white: 1, alpha: 0.1)
    
    view.addSubview(darkTextLabel)
    view.addSubview(shinyTextLabel)
    shinyTextLabel.layer.mask = gradientLayer
    
    let animation = CABasicAnimation(keyPath: "transform.translation.x")
    animation.fromValue = -view.frame.width
    animation.toValue = view.frame.width
    animation.repeatCount = Float.infinity
    animation.duration = 2
    
    gradientLayer.add(animation, forKey: nil)
  }
}
