//
//  ViewController.swift
//  SprybitPractical
//
//  Created by ghervadaJay on 29/07/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityMapView: MKMapView!

    var locationManager:CLLocationManager!
    
    let viewModel = ServiceModel()
    var weatherViewModel: WeatherViewModel?
    
    let locations = [
        Location(title: "New York, NY",    latitude: 40.713054, longitude: -74.007228),
        Location(title: "Los Angeles, CA", latitude: 34.052238, longitude: -118.243344),
        Location(title: "Chicago, IL",     latitude: 41.883229, longitude: -87.632398)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityMapView.delegate = self
        cityMapView.showsUserLocation = true

    }
 
    @IBAction func onTapButtonSearch(_ sender: UIButton) {
//        self.multiPalLocation()
        if citySearchBar.text != "" && citySearchBar.text!.count >= 3   {
            viewModel.getWeatherDetailApi(cityName: citySearchBar.text!) { success in
                self.weatherViewModel = success
                DispatchQueue.main.async {
                    self.cityPlace(log: self.weatherViewModel?.coord?.lon ?? 0.0, lat: self.weatherViewModel?.coord?.lat ?? 0.0, cityName: self.weatherViewModel?.name ?? "", country: self.weatherViewModel?.sys?.country ?? "")
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let detailVc = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
                                    detailVc?.cityName = self.citySearchBar.text!
                                detailVc?.weatherViewModel = self.weatherViewModel
                                self.navigationController?.pushViewController(detailVc!, animated: false)
                }
            }
        }
    }
    
    
    func multiPalLocation(){
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            cityMapView.centerCoordinate = annotation.coordinate;
            cityMapView.addAnnotation(annotation)
        }
    }
    func cityPlace(log: Double, lat: Double, cityName: String, country: String){
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = log

        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        cityMapView.setRegion(region, animated: true)

        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        myAnnotation.title = "\(cityName)"
        myAnnotation.subtitle = "\(country)"
        mapView(cityMapView, viewFor: myAnnotation)!.annotation = myAnnotation
        cityMapView.addAnnotation(myAnnotation)
    }

    internal  func mapView(_ mapView: MKMapView,
                          viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }

            let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                pinView!.image = UIImage(named:"india")!
            }
            else {
                pinView!.annotation = annotation
            }

            return pinView
        }
}

struct Location {
    let title: String
    let latitude: Double
    let longitude: Double
}

