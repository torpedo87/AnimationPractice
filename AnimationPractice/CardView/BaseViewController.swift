//
//  BaseViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 27/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  enum CardState {
    case expanded
    case collapsed
  }
  
  var cardViewController: CardViewController!
  var visualEffectView: UIVisualEffectView!
  let cardHeight: CGFloat = 600
  let cardHandleAreaHeight: CGFloat = 65
  var isCardVisible: Bool = false
  var nextCardState: CardState {
    return isCardVisible ? .collapsed : .expanded
  }
  var runningAnimations = [UIViewPropertyAnimator]()
  var animationProgressWhenInterrupted: CGFloat = 0
  
  private lazy var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "window")
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imgView)
    setupCard()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    imgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  func setupCard() {
    visualEffectView = UIVisualEffectView()
    visualEffectView.frame = view.frame
    view.addSubview(visualEffectView)
    
    cardViewController = CardViewController()
    addChild(cardViewController)
    view.addSubview(cardViewController.view)
    
    cardViewController.view.frame = CGRect(x: 0,
                                           y: view.frame.height - cardHandleAreaHeight,
                                           width: view.bounds.width,
                                           height: cardHeight)
    cardViewController.view.clipsToBounds = true
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
    let pan = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
    cardViewController.handleArea.addGestureRecognizer(tap)
    cardViewController.handleArea.addGestureRecognizer(pan)
  }
  
  @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
    switch recognizer.state {
    case .ended:
      animateTransitionIfNeeded(state: nextCardState, duration: 0.9)
    default:
      break
    }
  }
  
  @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
    
    switch recognizer.state {
    case .began:
      startInteractiveTransition(state: nextCardState, duration: 0.9)
    case .changed:
      let translation = recognizer.translation(in: cardViewController.handleArea)
      var fractionComplete = translation.y / cardHeight
      fractionComplete = isCardVisible ? fractionComplete : -fractionComplete
      updateInteractiveTransition(fractionCompleted: fractionComplete)
    case .ended:
      continueInteractiveTransition()
    default:
      break
    }
  }
  
  func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
    if runningAnimations.isEmpty {
      let frameAnimator = UIViewPropertyAnimator(duration: duration,
                                                 dampingRatio: 1) {
                                                  switch state {
                                                  case .expanded:
                                                    self.cardViewController.view.frame.origin.y =
                                                      self.view.frame.height - self.cardHeight
                                                  case .collapsed:
                                                    self.cardViewController.view.frame.origin.y =
                                                      self.view.frame.height - self.cardHandleAreaHeight
                                                  }
      }
      frameAnimator.addCompletion { _ in
        self.isCardVisible = !self.isCardVisible
        self.runningAnimations.removeAll()
      }
      frameAnimator.startAnimation()
      runningAnimations.append(frameAnimator)
      
      let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration,
                                                        curve: UIView.AnimationCurve.linear) {
                                                          switch state {
                                                          case .expanded:
                                                            self.cardViewController.view.layer.cornerRadius = 12
                                                          case .collapsed:
                                                            self.cardViewController.view.layer.cornerRadius = 0
                                                          }
      }
      
      cornerRadiusAnimator.startAnimation()
      runningAnimations.append(cornerRadiusAnimator)
      
      let blurAnimator = UIViewPropertyAnimator(duration: duration,
                                                dampingRatio: 1) {
                                                  switch state {
                                                  case .expanded:
                                                    self.visualEffectView.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                                                  case .collapsed:
                                                    self.visualEffectView.effect = nil
                                                  }
      }
      
      blurAnimator.startAnimation()
      runningAnimations.append(blurAnimator)
    }
  }
  
  func startInteractiveTransition(state: CardState, duration: TimeInterval) {
    if runningAnimations.isEmpty {
      animateTransitionIfNeeded(state: state, duration: duration)
    }
    
    for animator in runningAnimations {
      animator.pauseAnimation()
      animationProgressWhenInterrupted = animator.fractionComplete
    }
  }
  
  func updateInteractiveTransition(fractionCompleted: CGFloat) {
    for animator in runningAnimations {
      animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
    }
  }
  
  func continueInteractiveTransition() {
    for animator in runningAnimations {
      animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    }
  }
}
