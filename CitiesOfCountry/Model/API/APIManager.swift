//
//  APIManager.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/8/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import Foundation
import UIKit

func fetchData() {

    let urlOptional = URL(string: "https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json")
    let session = URLSession(configuration: URLSessionConfiguration.default)
    guard let url = urlOptional else { return }

    let dataTask = session.dataTask(with: url) { (data, response, error) in
        guard data != nil else { return }

        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)

        guard json != nil else { return }
        let dictionaryOptional = json as? Dictionary<String,[String]>
        guard let dictionary = dictionaryOptional else { return }

        for key in dictionary.keys {
            if key != "" {
                DispatchQueue.main.sync {
                    let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
                    do {

                        let country = Country(context: context!)
                        country.name = key

                        let arrayCity = dictionary[key]

                        for item in arrayCity! {

                            let city = City(context: context!)
                            city.name = item
                            country.addToCities(city)
                            city.country = country
                        }

                        try context?.save()

                    } catch {
                        print(" Помилка збереження: \(error)")
                    }
                }
            }
        }
    }
    dataTask.resume()
}



