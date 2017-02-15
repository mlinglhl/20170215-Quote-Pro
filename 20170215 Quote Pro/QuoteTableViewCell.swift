//
//  QuoteTableViewCell.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
