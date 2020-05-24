//
//  GeneralTableViewCell.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/10/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOrder: UILabel!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
