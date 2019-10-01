//
//  FavoritesViewController.swift
//  Save_lab
//
//  Created by EricM on 10/1/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var favorites = [Hit](){
        didSet{
            tableViewOutlet.reloadData()
        }
    }
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row].user
        cell.detailTextLabel?.text = "\(favorites[indexPath.row].tags)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData(){
        do {
           favorites = try PictureSaveHelper.saveHelper.getImage()
        } catch { fatalError("\(error)")}
    }
    

    

}
