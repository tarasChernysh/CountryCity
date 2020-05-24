//
//  TbDelegateForVC.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/9/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let index = indexPath.row
        indexForShowCities = index

        performSegue(withIdentifier: "showCities", sender: nil)
    }
    

}
