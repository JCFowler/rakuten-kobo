//
//  LaureateTableViewCell.swift
//  Rakuten_Kodo
//
//  Created by John Fowler on 1/10/21.
//

import UIKit

class LaureateTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var locationName: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var lat: UILabel!
    @IBOutlet var lng: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
