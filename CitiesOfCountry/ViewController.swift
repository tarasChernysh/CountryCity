//
//  ViewController.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/8/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showCountriesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.isHidden = true

        getData()

    }

    func getData() {

        let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let countOptional = try context?.count(for: fetchRequest)
            guard let count = countOptional  else { return }

            if count == 0 {
                fetchData()
            }

            let results = try context?.fetch(fetchRequest)
            countryNameArray = results!

        } catch  {
            print(error.localizedDescription)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showCities" {
            guard let vc = segue.destination as? CitiesTableViewController else { return }
            guard let index = indexForShowCities else { return }
            let tempCountry = countryNameArray[index]
            vc.country = tempCountry
        }
    }

    @IBAction func pressedShowCountries(_ sender: UIButton) {

        if tableView.isHidden {
            animate(toogle: true)
        } else {
            animate(toogle: false)
        }
    }

    func animate(toogle: Bool) {
        
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = true
            }
        }
    }
}



