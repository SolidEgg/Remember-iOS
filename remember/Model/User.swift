//
//  User.swift
//  remember
//
//  Created by 김민솔 on 5/11/25.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var nickname:String = ""
    @objc dynamic var email:String = ""
    @objc dynamic var password:String = ""
    @objc dynamic var farewellTarget:String = ""
}
