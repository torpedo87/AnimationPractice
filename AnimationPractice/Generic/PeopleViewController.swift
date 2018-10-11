//
//  PeopleViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 08/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class PeopleViewController: GenericTableViewController<PersonCell, Person> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    items = [
      Person(firstName: "poo", lastName: "raro"),
      Person(firstName: "poo2", lastName: "raro2"),
      Person(firstName: "poo3", lastName: "raro3")
    ]
  }
}
