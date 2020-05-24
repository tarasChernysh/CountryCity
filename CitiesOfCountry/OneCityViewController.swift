//
//  OneCityViewController.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/9/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import UIKit
import SafariServices

class OneCityViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var safariButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    var cityNameString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName.text = cityNameString

        getData()

    }

    func getData() {

        guard let key = cityNameString else { return }
        let urlOptional = URL(string: "http://api.geonames.org/wikipediaSearchJSON?q=\(key)&maxRows=10&username=demo")
        guard let url = urlOptional else { return }

        let http = APIManager_2()
        
        http.retriveData(url: url) { [weak self] (data) in

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let dictionaryOptional = json as? Dictionary<String,Any>
                let some = dictionaryOptional!["geonames"] as? [Dictionary<String,Any>]
                guard let tempArr = some else { return }
                let first = tempArr[0]
                let description = first["summary"] as? String

                self?.infoLabel.text = description

                let imageStringOptional = first["thumbnailImg"] as? String
                guard let imageString = imageStringOptional else { return }
                let imageURLOptional = URL(string: imageString)
                guard let imageURL = imageURLOptional else { return }
                let dataImageOptional = try? Data(contentsOf: imageURL)
                guard let dataImage = dataImageOptional else { return }

                self?.imageView.image = UIImage(data: dataImage)

                let urlWiki = first["wikipediaUrl"] as? String
                guard let someUr = urlWiki else { return }

                self?.safariButton.setTitle(someUr, for: .normal)

            } catch {

                print(error.localizedDescription)

            }
        }
    }

    @IBAction func pressedShowInSafariButton(_ sender: UIButton) {

        let textOptional = sender.titleLabel?.text
        guard let text = textOptional else { return }

        if text.lowercased().hasPrefix("http://") == false {
            let text2 = "http://\(text)"
            let urlOptional = URL(string: text2)
            guard let url = urlOptional else { return }

            let sfc = SFSafariViewController(url: url)
            self.present(sfc, animated: true, completion: nil)

        }
    }
}
