//
//  ImageDetailViewController.swift
//  Save_lab
//
//  Created by EricM on 10/1/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    var picture: Hit!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    @IBAction func favorite(_ sender: UIButton) {
        do{
            try PictureSaveHelper.saveHelper.savePicture(picture: picture)
            
        } catch {fatalError(error.localizedDescription)}
    }
    override func viewDidLoad() {
        ImageHelper.shared.getImage(urlStr: picture.largeImageURL ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let picture):
                    self.image2.image = picture
                case .failure(let error):
                    print(error)
                }
            }
        }
        user.text = "Provider: \(picture.user)"
        tags.text = "Tags: \(picture.tags)"
        likes.text = "Likes: \(picture.likes)"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
