//
//  Saving.swift
//  Save_lab
//
//  Created by EricM on 10/1/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

class PictureSaveHelper {
    private init(){}
    static let saveHelper = PictureSaveHelper()

    func savePicture(picture: Hit) throws {
        try persistenceHelper.save(newElement: picture)
    }
    private let persistenceHelper = PersistenceHelper<Hit>(fileName: "saveImage.plist")
    func getImage()throws -> [Hit]{
        return try persistenceHelper.getObjects()
    }

}
