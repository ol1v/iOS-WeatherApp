//
//  FavoritesViewController.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-09.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import UIKit


class FavoritesViewController: UIViewController {
    var favoriteCities: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        return cell
        
    }
 
    
    
}

