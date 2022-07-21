//
//  DataController.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 18.07.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "GoalModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error init \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("save")
        } catch {
            print("Error save \(error.localizedDescription)")
        }
    }
    
    func addGoal(name: String, allPrice: Int64, current: Int64, valueIndex: Int16, tagIndex: Int16, context: NSManagedObjectContext) {
        let goal = Goal(context: context)
        goal.id = UUID()
        goal.date = Date()
        goal.name = name
        goal.price = allPrice
        goal.current = current
        goal.colorIndex = tagIndex
        goal.valueIndex = valueIndex
        
        save(context: context)
    }
    
    func deleteGoal(goal: Goal, context: NSManagedObjectContext) {
        context.delete(goal)
        
        save(context: context)
    }
}
