//
//  MessageObject.swift
//  remember
//
//  Created by 김민솔 on 5/1/25.
//

import Foundation
import RealmSwift

class MessageObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var content: String
    @Persisted var date: Date
}
