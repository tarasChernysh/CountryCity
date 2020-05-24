//
//  DataSourseForVC.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/9/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GeneralTableViewCell

        let item = countryNameArray[indexPath.row]

        cell.name?.text = item.name
        cell.numberOrder?.text = String(indexPath.row + 1)

        return cell
    }

}
