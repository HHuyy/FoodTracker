//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by tham gia huy on 5/18/18.
//  Copyright © 2018 tham gia huy. All rights reserved.
//

import UIKit

import os.log

class MealTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataService.share.meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.nameLabel.text = DataService.share.meals[indexPath.row].name
        cell.photoImageView.image = DataService.share.meals[indexPath.row].photo
        cell.ratingControl.rating = DataService.share.meals[indexPath.row].rating
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataService.share.meals.remove(at: indexPath.row)
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
}
