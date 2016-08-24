//
//  FetchViewController.swift
//  TheBackgrounder
//
//  Created by Ray Fix on 12/9/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController {
  
  @IBOutlet var updateLabel: UILabel!
  
  private var time: Date?
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .long
    return formatter
  }()
  
  func fetch(_ completion: () -> Void) {
    time = Date()
    completion()
  }
  
  func updateUI() {
    if let time = time {
      updateLabel.text = dateFormatter.string(from: time)
    } else {
      updateLabel.text = "Not yet updated"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  @IBAction func didTapUpdate(_ sender: UIButton) {
    fetch { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.updateUI()
    }
  }
}
