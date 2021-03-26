//
//  Reminder.swift
//  MyRemindersApp
//
//  Created by user192371 on 3/26/21.
//

import Foundation
class Reminder {

    var id:String
    var title:String
    var description:String
    var date:String

    init(id:String, title:String, description:String, date:String) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
    }
}
