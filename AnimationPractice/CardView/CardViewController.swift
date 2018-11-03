//
//  CardViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 27/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
  
  lazy var handleArea: UIView = {
    let slideView = UIView()
    slideView.backgroundColor = .white
    slideView.translatesAutoresizingMaskIntoConstraints = false
    return slideView
  }()
  
  private lazy var contentArea: UIView = {
    let contentsView = UIView()
    contentsView.backgroundColor = .yellow
    contentsView.translatesAutoresizingMaskIntoConstraints = false
    return contentsView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(handleArea)
    view.addSubview(contentArea)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    handleArea.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    handleArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    handleArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    handleArea.heightAnchor.constraint(equalToConstant: 65).isActive = true
    
    contentArea.topAnchor.constraint(equalTo: handleArea.bottomAnchor).isActive = true
    contentArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    contentArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    contentArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}
