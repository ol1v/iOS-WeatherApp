//
//  MyCell.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-09.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
