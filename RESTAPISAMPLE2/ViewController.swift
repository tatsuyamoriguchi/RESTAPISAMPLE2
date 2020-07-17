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
        
        let url = "https://api.covid19api.com/summary"
        getData(from: url)
    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error
            in
            guard let data = data, error == nil else {
                print("Somethign went wrong")
                return
            }
            
            // Get and decode data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Failed to convert \(error)")
                
            }
            guard let json = result else {
                return
            }
            print(json.Global)
            print("")
            print(json.Global.NewConfirmed)
            print("")
            print(json.Date)
            print("")
            print(json.Countries.count)
            
        })
        task.resume()
    }
}

struct Response: Codable {
    let Global: MyResult
    let Date: String
    var Countries: [MyCountries]
}

struct MyResult: Codable {
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
   

}

struct MyCountries: Codable {
    let Country: String
    let CountryCode: String
    let Slug: String
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
    let Date: String
}

/*
 {"Global":
     {
         "NewConfirmed":249767,
         "TotalConfirmed":13804565,
         "NewDeaths":5779,
         "TotalDeaths":589895,
         "NewRecovered":152273,
         "TotalRecovered":7710874
     },
     "Countries":
     [    {
             "Country":"Afghanistan",
             "CountryCode":"AF",
             "Slug":"afghanistan",
             "NewConfirmed":76,
             "TotalConfirmed":35070,
             "NewDeaths":19,
             "TotalDeaths":1113,
             "NewRecovered":368,
             "TotalRecovered":22824,
             "Date":"2020-07-17T19:48:11Z",
             "Premium":{}
         },
         {
             "Country":"Albania",
             "CountryCode":"AL",
             "Slug":"albania",
             "NewConfirmed":99,
             "TotalConfirmed":3851,
             "NewDeaths":3,
             "TotalDeaths":104,
             "NewRecovered":46,
             "TotalRecovered":2137,
             "Date":"2020-07-17T19:48:11Z",
             "Premium":{}
         },
     ],

     "Date":"2020-07-17T19:48:11Z"
 }
*/
