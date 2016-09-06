//
//  WhateverViewController.swift
//  TheBackgrounder
//
//  Created by Ray Fix on 12/9/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit

class WhateverViewController: UIViewController {
  
  var previous = NSDecimalNumber.one
  var current = NSDecimalNumber.one
  var position: UInt = 1
  var updateTimer: Timer?
  
  
  @IBOutlet var resultsLabel: UILabel!
  
  @IBAction func didTapPlayPause(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    if sender.isSelected {
      resetCalculation()
      updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                         selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
    } else {
      updateTimer?.invalidate()
      updateTimer = nil
    }
  }
  
  func registerBackgroundTask() {
    
  }
  
  func endBackgroundTask() {
    
  }
  
  func calculateNextNumber() {
    let result = current.adding(previous)
    
    let bigNumber = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)
    if result.compare(bigNumber) == .orderedAscending {
      previous = current
      current = result
      position += 1
    } else {
      // This is just too much.... Start over.
      resetCalculation()
    }
    
    let resultsMessage = "Position \(position) = \(current)"
    resultsLabel.text = resultsMessage
    
  }
 
  func resetCalculation() {
    previous = NSDecimalNumber.one
    current = NSDecimalNumber.one
    position = 1
  }
  
  
}
