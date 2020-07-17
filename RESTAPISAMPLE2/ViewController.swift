//
//  ViewController.swift
//  RESTAPISAMPLE2
//
//  Created by Tatsuya Moriguchi on 7/16/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&formatted=1"
        getData(from: url)

    }
    
    private func getData(from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
//            print(json.status)
//            print(json.results.sunrise)
//            print(json.results.sunset)
//            print(json.results.day_length)
            
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_noon)
            print(json.results.sunrise)

        })
        task.resume()
    }
}

struct Response: Codable {
    // What is Codable? Protcol programming?
    // Protcol that Swift provides decodes data from REST API server
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: String
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_eng: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

/*
 {
   "results":
   {
     "sunrise":"7:27:02 AM",
     "sunset":"5:05:55 PM",
     "solar_noon":"12:16:28 PM",
     "day_length":"9:38:53",
     "civil_twilight_begin":"6:58:14 AM",
     "civil_twilight_end":"5:34:43 PM",
     "nautical_twilight_begin":"6:25:47 AM",
     "nautical_twilight_end":"6:07:10 PM",
     "astronomical_twilight_begin":"5:54:14 AM",
     "astronomical_twilight_end":"6:38:43 PM"
   },
    "status":"OK"
 }
 */
