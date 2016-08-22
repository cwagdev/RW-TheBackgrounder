//
//  LocationViewController.swift
//  TheBackgrounder
//
//  Created by Ray Fix on 12/9/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {
  var locations = [MKPointAnnotation]()
  
  lazy var locationManager: CLLocationManager! = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.delegate = self
    manager.requestAlwaysAuthorization()
    return manager
  }()
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBAction func enabledChanged(_ sender: UISwitch) {
    if sender.isOn {
      locationManager.startUpdatingLocation()
    } else {
      locationManager.stopUpdatingLocation()
    }
  }
  
  @IBAction func accuracyChanged(_ sender: UISegmentedControl) {
    let accuracyValues = [
      kCLLocationAccuracyBestForNavigation,
      kCLLocationAccuracyBest,
      kCLLocationAccuracyNearestTenMeters,
      kCLLocationAccuracyHundredMeters,
      kCLLocationAccuracyKilometer,
      kCLLocationAccuracyThreeKilometers]
    
    locationManager.desiredAccuracy = accuracyValues[sender.selectedSegmentIndex];
  }
  
  // MARK: - CLLocationManagerDelegate
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let mostRecentLocation = locations.last else {
      return
    }
    
    // Add another annotation to the map.
    let annotation = MKPointAnnotation()
    annotation.coordinate = mostRecentLocation.coordinate
    
    // Also add to our map so we can remove old values later
    self.locations.append(annotation)
    
    // Remove values if the array is too big
    while locations.count > 100 {
      let annotationToRemove = self.locations.first!
      self.locations.remove(at: 0)
      
      // Also remove from the map
      mapView.removeAnnotation(annotationToRemove)
    }
    
    if UIApplication.shared.applicationState == .active {
      mapView.showAnnotations(self.locations, animated: true)
    } else {
      NSLog("App is backgrounded. New location is %@", mostRecentLocation)
    }
  }
}

