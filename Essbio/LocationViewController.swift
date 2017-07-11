//
//  LocationViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 05-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


  // activar gps con mapa fijando un punto especifico desde tu posicion actual
    

    @IBAction func showMeWhere(_ sender: Any) {
        
        let latitude:CLLocationDegrees = -36.833428
        let longitude:CLLocationDegrees = -73.056789
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "ESSBIO STORE"
        mapItem.openInMaps(launchOptions: options)
        
        

        

    }

    

}
