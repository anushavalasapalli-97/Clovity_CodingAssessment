//
//  CountriesTableViewCell.swift
//  Clovity-CodeAssessment
//
//  Created by AnushaValasapalli on 7/26/23.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var vwBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
