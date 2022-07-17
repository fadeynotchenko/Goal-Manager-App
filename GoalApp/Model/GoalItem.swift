//
//  GoalItem.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import Foundation
import RealmSwift

class GoalItem: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var goalName: String
    @Persisted var goalPrice: String
    @Persisted var valueIndex: Int
    @Persisted var goalCurrent: String
    @Persisted var tagIndex: Int
}
