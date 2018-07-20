//
//  DataService.swift
//  FoodTracker
//
//  Created by tham gia huy on 5/25/18.
//  Copyright © 2018 tham gia huy. All rights reserved.
//

import UIKit


class DataService {
    static let share: DataService = DataService()
    private var _meals: [Food]?
    var meals: [Food] {
        get {
            if _meals == nil {
                loadSampleMeals()
            }
            return _meals ?? []
        }
        set {
            _meals = newValue
        }
    }
    
    func loadSampleMeals() {
        _meals = []
//        guard let meal1 = Meal(name: "Hamburger", photo: #imageLiteral(resourceName: "hamburger"), rating: 3) else {return}
//        guard let meal2 = Meal(name: "Pizza", photo: #imageLiteral(resourceName: "pizza"), rating: 5) else {return}
//        guard let meal3 = Meal(name: "Spaghetti", photo: #imageLiteral(resourceName: "spaghetti"), rating: 4) else {return}
//        _meals = [meal1, meal2, meal3]
        do {
            _meals = try AppDelegate.context.fetch(Food.fetchRequest()) as? [Food]
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
//    func insertNewMeal(meal: Meal) {
//        _meals?.append(meal)
//    }
    
    func saveMeal() {
        AppDelegate.saveContext()
        loadSampleMeals()
    }
    
    func deleteMeal(from indexPath: IndexPath) {
        guard let object = _meals else { return }
        AppDelegate.context.delete(object[indexPath.row])
        saveMeal()
    }
}
