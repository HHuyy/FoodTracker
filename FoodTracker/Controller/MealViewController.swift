//
//  ViewController.swift
//  FoodTracker
//
//  Created by tham gia huy on 5/17/18.
//  Copyright © 2018 tham gia huy. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var index: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        if let indexPath = index {
            navigationItem.title = indexPath.name
            textField.text = indexPath.name
            photoImageView.image = indexPath.photo as? UIImage
            ratingControl.rating = Int(indexPath.rate)
            
        }
        updateSaveButtonState()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func savebutt(_ sender: UIBarButtonItem) {
//        let name = textField.text ?? ""
//        let photo = photoImageView.image
//        let rating = ratingControl.rating
//        if let indexPath = index {
//            DataService.share.meals[indexPath].name = name
//            DataService.share.meals[indexPath].photo = photo
//            DataService.share.meals[indexPath].rate = Int16(rating)
//        } else {
//            guard let meal = Meal(name: name, photo: photo, rating: rating) else { return}
//            DataService.share.insertNewMeal(meal: meal)
//        }
        if index == nil {
            index = Food(context: AppDelegate.context)
        }
        guard textField.text != nil else { return }
        guard ratingControl.rating != nil else { return }
        index?.name = textField.text
        index?.photo = photoImageView.image
        index?.rate = Int16(ratingControl.rating)
        DataService.share.saveMeal()
        navigationController?.popViewController(animated: true)
    }
    
    private func updateSaveButtonState() {
        let text = textField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

