//
//  ImageDetailViewController.swift
//  Save_lab
//
//  Created by EricM on 10/1/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBAction func favorite(_ sender: UIButton) {
        do{
           try PictureSaveHelper.saveHelper.savePicture(picture: <#T##Image#>)
            
        } catch {fatalError(error.localizedDescription)}
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
