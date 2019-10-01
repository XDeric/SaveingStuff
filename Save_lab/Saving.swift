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

    func savePicture(picture: Image) throws {
        try persistenceHelper.save(newElement: picture)
    }
    private let persistenceHelper = PersistenceHelper<Image>(fileName: "saveImage.plist")
    func getImage()throws -> [Image]{
        return try persistenceHelper.getObjects()
    }

}
