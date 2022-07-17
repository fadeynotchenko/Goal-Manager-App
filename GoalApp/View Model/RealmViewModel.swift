//
//  RealmViewModel.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import Foundation
import RealmSwift

class RealmViewModel: ObservableObject {
    
    @Published var goalName = ""
    @Published var goalPrice = ""
    @Published var goalCurrent = ""
    @Published var valueIndex = 0
    @Published var tagIndex = 0
    
    @Published var goals: [GoalItem] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let db = try? Realm() else { return }
        
        let results = db.objects(GoalItem.self)
        self.goals = results.compactMap({ (goal) -> GoalItem? in
            return goal
        })
    }
    
    func addData() {
        let goal = GoalItem()
        goal.goalName = goalName
        goal.goalPrice = goalPrice
        goal.goalCurrent = goalCurrent
        goal.valueIndex = valueIndex
        goal.tagIndex = tagIndex
        
        guard let db = try? Realm() else { return }
        
        try? db.write {
            db.add(goal)
        }
        
        deInitData()
        
        fetchData()
    }
    
    func deleteData(goal: GoalItem) {
        guard let db = try? Realm() else { return }
        
        try? db.write {
            db.delete(goal)
        }
        
        fetchData()
    }
    
    func deInitData() {
        goalName = ""
        goalPrice = ""
        goalCurrent = ""
        valueIndex = 0
        tagIndex = 0
    }
}
