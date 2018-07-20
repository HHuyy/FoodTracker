//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by tham gia huy on 5/18/18.
//  Copyright © 2018 tham gia huy. All rights reserved.
//

import UIKit

import os.log

class MealTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearchActive: Bool = false
    var meals: [Food] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        meals = DataService.share.meals
//        searchBar.showsCancelButton = true
        DataService.share.loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text?.removeAll()
//        searchBar.resignFirstResponder()
//        meals = DataService.share.meals
//        tableView.reloadData()
//    }
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        isSearchActive = searchBar.text != ""
//    }
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        isSearchActive = false
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.nameLabel.text = meals[indexPath.row].name
        cell.photoImageView.image = meals[indexPath.row].photo as? UIImage
        cell.ratingControl.rating = Int(meals[indexPath.row].rate)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            if isSearchActive {
//                if let index = DataService.share.meals.index(of: meals[indexPath.row]) {
//                    DataService.share.meals.remove(at: index)
//                DataService.share.deleteMeal(from: indexPath)
//
//                }
//            }
            DataService.share.deleteMeal(from: indexPath)
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard let mealDetailViewController = segue.destination as? MealViewController else {return}
//        guard let selectedMealCell = sender as? MealTableViewCell else {return}
//        guard let indexPath = tableView.indexPath(for: selectedMealCell) else {return}
//        mealDetailViewController.index = indexPath.row
        guard let mealViewController = segue.destination as? MealViewController else { return  }
        if let indexPath = tableView.indexPathForSelectedRow {
            if isSearchActive {
                mealViewController.index = meals[indexPath.row]
            } else {
                mealViewController.index = DataService.share.meals[indexPath.row]
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = searchText != ""
        print(isSearchActive)
        meals = searchText.isEmpty ? DataService.share.meals : DataService.share.meals.filter({ (item: Food) -> Bool in
            return (item.name?.lowercased().contains(searchBar.text!.lowercased()))!
        })
        tableView.reloadData()
    }
}
