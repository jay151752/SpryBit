//
//  ServiceModel.swift
//  SprybitPractical
//
//  Created by ghervadaJay on 29/07/22.
//

import Foundation

public class ServiceModel{
    
    static let sharedIntance = ServiceModel()
    
    typealias CompletionHandler = (_ success: WeatherViewModel) -> Void
    
    func getWeatherDetailApi(cityName: String, completinp: @escaping CompletionHandler){
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName )&APPID=f7ae896d963f6d47ee09e3a70ee4ceb5")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let books = try? JSONDecoder().decode(WeatherViewModel.self, from: data) {
                    print(books)
                    completinp(books)
                    self.getWeatherDataFromApi(modelData: books)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    
    
    func getWeatherDataFromApi(modelData: WeatherViewModel){
        print(modelData)
    }
}
