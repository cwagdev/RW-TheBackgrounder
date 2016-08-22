//
//  FetchViewController.swift
//  TheBackgrounder
//
//  Created by Ray Fix on 12/9/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController {
  
  @IBOutlet weak var updateLabel: UILabel?
  var time: Date?
  
  func fetch(_ completion: () -> Void) {
    time = Date()
    completion()
  }
  
  func updateUI() {
    if let time = time {
      let formatter = DateFormatter()
      formatter.dateStyle = .short
      formatter.timeStyle = .long
      updateLabel?.text = formatter.string(from: time)
    }
    else {
      updateLabel?.text = "Not yet updated"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  @IBAction func didTapUpdate(_ sender: UIButton) {
    fetch { self.updateUI() }
  }
}
