//
//  TableViewCell.swift
//  coreData
//
//  Created by Pragath on 10/03/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var employeeName: UILabel!
    
    @IBOutlet weak var employeeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
