//
//  APIHelper.swift
//  closure
//
//  Created by Andrew Foster on 5/29/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import Foundation

class APIHelper {
    
    
    func getTemp(tempAquired:@escaping (_ temp:String, _ success: Bool) -> Void) {

        let session = URLSession.shared
//        let weatherUrl = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")!
        
        // iOS 10 Update
        guard let url = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys") else {
            print("Couldn't create URL")
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                print("Redy to go")
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    if let query = dict["query"] as? [String:AnyObject] {
                        if let results = query["results"] as? [String:AnyObject] {
                            if let channel = results["channel"] as? [String:AnyObject] {
                                if let item = channel["item"] as? [String:AnyObject] {
                                    if let condition = item["condition"] as? [String:AnyObject] {
                                        if let temp = condition["temp"] as? String {
                                            tempAquired(temp, true)
                                            print(temp)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    
                } catch {
                    tempAquired("", false)
                }
                
            } else {
                print("Error occured!")
                tempAquired("", false)
            }
            
        }.resume()
        
    }
}
