//
//  ViewController.swift
//  SprybitPractical
//
//  Created by ghervadaJay on 29/07/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityMapView: MKMapView!

    var locationManager:CLLocationManager!
    
    let viewModel = ServiceModel()
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 
 
    @IBAction func onTapButtonSearch(_ sender: UIButton) {
        if citySearchBar.text != "" && citySearchBar.text!.count >= 3   {
            viewModel.getWeatherDetailApi(cityName: citySearchBar.text!) { success in
                self.weatherViewModel = success
                DispatchQueue.main.async {
                    self.cityPlace(log: self.weatherViewModel?.coord?.lon ?? 0.0, lat: self.weatherViewModel?.coord?.lat ?? 0.0, cityName: self.weatherViewModel?.name ?? "")
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let detailVc = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
                                    detailVc?.cityName = self.citySearchBar.text!
                                detailVc?.weatherViewModel = self.weatherViewModel
                                self.navigationController?.pushViewController(detailVc!, animated: false)
                }
            }
        }
    }
    
    
    func cityPlace(log: Double, lat: Double, cityName: String){
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = log
                print(lat)
            print(log)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        cityMapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        myAnnotation.title = "\(cityName)"
        cityMapView.addAnnotation(myAnnotation)
    }
    

}

