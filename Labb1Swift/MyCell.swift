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
    
    /*override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //addSubview(tempLabel)
        //addSubview(cityLabel)
        //addSubview(conditionLabel)
        addSubview(imageLabel)
        setImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    func configureImageView() {
        imageLabel.layer.cornerRadius = 10
        imageLabel.clipsToBounds      = true
    }
    func setImageViewConstraints() {
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imageLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageLabel.widthAnchor.constraint(equalTo: imageLabel.heightAnchor, multiplier: 16/9).isActive = true
    }
    
}
