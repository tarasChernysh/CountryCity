//
//  CitiesTableViewController.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/8/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import UIKit
import CoreData

var cityNameForDownload: String?

class CitiesTableViewController: UITableViewController {

    var country: Country?


    override func viewDidLoad() {
        super.viewDidLoad()

        
        

    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempCountrySet = country?.cities

        guard let cities = tempCountrySet else { return 2 }

        return cities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        guard let citiesSet = country?.cities else { return cell }

        let citiesArray = citiesSet.allObjects as NSArray

        let citiesSortAny = citiesArray.sorted(by: { (a, b) -> Bool in

            return (a as? City)!.name! < (b as? City)!.name!

            })

        let citiesSortArray = citiesSortAny as NSArray

        let city = citiesSortArray[indexPath.row] as? City

        cell.textLabel?.text = city?.name
        //cell.numberOrder.text = String(indexPath.row + 1)

        //guard let name = cell.textLabel?.text else { return cell }

        guard let name = city?.name else { return cell }

        cityNameForDownload = name

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        indexPathForShowOneCity = indexPath

        performSegue(withIdentifier: "showOneCity", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showOneCity" {
            let vc = segue.destination as? OneCityViewController

            guard let indexPath = indexPathForShowOneCity else { return }

            let cell = tableView.cellForRow(at: indexPath)

            

            vc?.cityNameString = cell?.textLabel?.text
            
            //vc?.infoString = returnString

        }
    }
}
