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
    var filteredData: String?
    var MEal: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        MEal = DataService.share.meals
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MEal.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.nameLabel.text = MEal[indexPath.row].name
        cell.photoImageView.image = MEal[indexPath.row].photo
        cell.ratingControl.rating = MEal[indexPath.row].rating
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MEal.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let mealDetailViewController = segue.destination as? MealViewController else {return}
        guard let selectedMealCell = sender as? MealTableViewCell else {return}
        guard let indexPath = tableView.indexPath(for: selectedMealCell) else {return}
        mealDetailViewController.index = indexPath.row
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MEal = searchText.isEmpty ? DataService.share.meals : DataService.share.meals.filter({ (item: Meal) -> Bool in
            if item.name.lowercased().contains(searchBar.text!.lowercased()) || item.name.uppercased().contains(searchBar.text!.uppercased()) {
                return true
            } else {
                return false
            }
        })
        tableView.reloadData()
    }
}
