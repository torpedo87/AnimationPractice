//
//  GenericTableViewController.swift
//  AnimationPractice
//
//  Created by junwoo on 08/10/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit

class GenericTableViewController<T: GenericCell<U>, U>: UITableViewController {
  
  let cellId = "id"
  private lazy var rc: UIRefreshControl = {
    let rc = UIRefreshControl()
    rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    tableView.refreshControl = rc
    return rc
  }()
  var items = [U]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(T.self, forCellReuseIdentifier: cellId)
    tableView.tableFooterView = UIView()
    
  }
  
  @objc func handleRefresh() {
    tableView.refreshControl?.endRefreshing()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? GenericCell<U> {
      cell.item = items[indexPath.row]
      return cell
    }
    return UITableViewCell()
  }
}
