//
//  MyCell.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-09.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /*addSubview(tempLabel)
        configureTempLabel()
        setTempLabelConstraints()*/
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureTempLabel() {
        self.tempLabel.layer.cornerRadius = 10
        self.tempLabel.numberOfLines = 0
        self.tempLabel.adjustsFontSizeToFitWidth = true
    }
    func setTempLabelConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tempLabel.widthAnchor.constraint(equalTo: tempLabel.heightAnchor,multiplier: 16/0).isActive = true
        
    }
}
