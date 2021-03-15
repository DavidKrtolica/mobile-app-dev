//
//  Note.swift
//  FirebaseDemo
//
//  Created by user192371 on 3/1/21.
//

import Foundation
class Note {
    
    var id:String
    var text:String
    var imgRef:String
    
    init(id:String, text:String, imgRef:String) {
        self.id = id
        self.text = text
        self.imgRef = imgRef
    }
    
}
