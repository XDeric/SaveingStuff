//
//  ViewController.swift
//  Save_lab
//
//  Created by EricM on 9/30/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var images = [Hit](){
        didSet{
            self.collectionOutlet.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionOutlet: UICollectionView!
    var searchString: String? = nil
    
    var imageSearchResults: [Hit] {
        guard let _ = searchString else {
            return images
        }
        guard searchString != "" else {
            return images
        }
        let results = images.filter{$0.tags.components(separatedBy: ",").contains(searchString!.lowercased())}
        return results
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
        loadData(searching: searchString)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSearchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageStuff = imageSearchResults[indexPath.row]
        if let cell = collectionOutlet.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? ImageCollectionViewCell {
            
            ImageHelper.shared.getImage(urlStr: imageStuff.largeImageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let picture):
                        cell.image1.image = picture
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOutlet.dataSource = self
        collectionOutlet.delegate = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func loadData(searching: String?) {
        APIManager.manager.getImage(search: searching ?? "puupy"){ (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let picture):
                    self.images = picture
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var ImageVC = segue.destination as? ImageDetailViewController,
            let indexPath = collectionOutlet.indexPath(for: sender as! UICollectionViewCell)
            else {
                fatalError("no segue")
        }
        let path = imageSearchResults[indexPath.row]
        ImageVC.picture = path
    }
}



