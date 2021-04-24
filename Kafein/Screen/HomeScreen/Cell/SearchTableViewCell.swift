//
//  SearchTableViewCell.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
