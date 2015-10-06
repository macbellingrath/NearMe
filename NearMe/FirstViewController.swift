//
//  FirstViewController.swift
//  NearMe
//
//  Created by Mac Bellingrath on 10/5/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.



// Normal

// - change the marker to an image
// - turn “showsUserLocation” back on & fix it so that you see the blue dot again (currently being overwritten)
// - add iboutlet for detail label & pass the annotation title to the detail label

// Hard

// - add an image to the leftcalloutaccesoryview
// - add multiple annotations

// Nightmare

// - get JSON data from Foursquare and place it as a fake data model within app
// - create annotations based on data
//

import UIKit
import MapKit
import CoreLocation

public class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    @IBAction func resetButtonpressed(sender: UIButton) {
       
        if myMapView.annotations.isEmpty {
            
           return
            
        } else {
        
            myMapView.removeAnnotations(self.myMapView.annotations)
            
        }
        
    }
    
 
    //MapView
    @IBOutlet weak var myMapView: MKMapView! {
        didSet {
            manager.requestLocation()
            
        }
    }
    
    @IBOutlet var longPressGR: UILongPressGestureRecognizer!
    //Location Manager
    var manager = CLLocationManager()
   
    
    
    @IBAction func refreshLocationButtonTapped(sender: UIBarButtonItem) {
        manager.requestLocation()
    }
    
    public func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        // use to configure the MKMapKit()
        
        
    }
    
    @IBAction func longPress(sender: UILongPressGestureRecognizer) {
        
        print("gesture recognized")
        
        
        if sender.state != UIGestureRecognizerState.Ended {
            return
        }
        let touchPoint: CGPoint = sender.locationInView(myMapView)
        let touchMapCoordinate: CLLocationCoordinate2D = myMapView.convertPoint(touchPoint, toCoordinateFromView: myMapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        annotation.title = "Lat: \(touchMapCoordinate.latitude), Long: \(touchMapCoordinate.longitude)"
        
        myMapView.addAnnotation(annotation)

    }
    
   
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressGR.delegate = self
        longPressGR.minimumPressDuration = 2.0
        
        myMapView.addGestureRecognizer(longPressGR)
        
        //assign mapview delegate to self
        myMapView.delegate = self
        
        //ask for location
        manager.requestWhenInUseAuthorization()
        
        //assign manager delegate to self
        manager.delegate = self
  
        //show user location
        myMapView.showsUserLocation = true
        
       //request initial location
        manager.requestLocation()
      
        
        
    }
    
   
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
      
        for location in locations {
            
            
            print(location.coordinate.latitude ,",", location.coordinate.latitude)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location.coordinate
            annotation.title = "This is cool"
        
           
            myMapView.addAnnotation(annotation)
           
        }
       
    }
    
    
    func handleGesture(sender: UIGestureRecognizer) {
        print("gesture recognized")
        
      
        if sender.state != UIGestureRecognizerState.Ended {
            return
        }
        let touchPoint: CGPoint = sender.locationInView(myMapView)
        let touchMapCoordinate: CLLocationCoordinate2D = myMapView.convertPoint(touchPoint, toCoordinateFromView: myMapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        annotation.title = "Lat: \(touchMapCoordinate.latitude), Long: \(touchMapCoordinate.longitude)"
        
        myMapView.addAnnotation(annotation)
        
    }
    

 

    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    
        
        let ac = UIAlertController(title: "Uh-oh", message: "Something went wrong.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Cancel , handler: nil))
        presentViewController(ac, animated: true) { () -> Void in
            print("Presented alert")
            }
        
    }
    
    
    
    
    public func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if myMapView.showsUserLocation {
            
        
        
        if myMapView.annotations.isEmpty {
            print("empty")
        
        
        //Custom Annotation View
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("Pin")
        if annotationView == nil {
            
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
             let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.image = UIImage(named: "swift")
            annotationView?.leftCalloutAccessoryView = imageView
            
          
//            annotationView?.pinTintColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
            
            annotationView?.canShowCallout = true
            

        }
        

        let button = UIButton(type: .DetailDisclosure)
        button.addTarget(self, action: "showDetail:", forControlEvents: .TouchUpInside)
        
  
        annotationView?.rightCalloutAccessoryView = button
 
        return annotationView
            }
        }
        return nil
    }
    
    
    
   
    //Called when detail button is pressed
    func showDetail(sender: UIButton) {
        
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") {
        
            
        viewController.view.backgroundColor = UIColor.cyanColor()
            
        navigationController?.pushViewController(viewController, animated: true)
 
        }
    }
    
}



extension MKMapViewDelegate {
    
    var manager: CLLocationManager {
        return CLLocationManager()
    }
    
    func setup() {
 
        manager.requestWhenInUseAuthorization()
    
    }
}
