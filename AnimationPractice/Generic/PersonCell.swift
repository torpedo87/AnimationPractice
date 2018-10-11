//
//  PersonCell.swift
//  AnimationPractice
//
//  Created by junwoo on 08/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class PersonCell: GenericCell<Person> {
  override var item: Person! {
    didSet {
      textLabel?.text = "\(item.firstName), \(item.lastName)"
    }
  }
}
