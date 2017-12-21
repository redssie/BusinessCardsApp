//
//  VerticalCustomTableViewCell.swift
//  test
//
//  Created by Maja Zafran on 20/12/2017.
//  Copyright © 2017 Maja Zafran. All rights reserved.
//

import UIKit

class VerticalCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var verticalPhoneLabel: UILabel!
    @IBOutlet weak var verticalEmailLabel: UILabel!
    @IBOutlet weak var verticalCompanyLabel: UILabel!
    @IBOutlet weak var verticalNameLabel: UILabel!
    @IBOutlet weak var verticalCellView: UIView!
    @IBOutlet weak var imageIsOnTop: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
