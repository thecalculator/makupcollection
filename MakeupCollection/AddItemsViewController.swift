//
//  AddItemsViewController.swift
//  MakeupCollection
//
//  Created by Shilpa Ghanmode on 8/3/17.
//  Copyright © 2017 com.tridev. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var makeupitemname: UITextField!
    @IBOutlet weak var makeupImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var makeup : MakeUps? = nil
    
    @IBOutlet weak var addbutton: UIButton!
    
    @IBOutlet weak var deletebutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        deletebutton.isHidden = true
        if makeup != nil {
            makeupImageView.image = UIImage(data: makeup!.image! as Data)
            makeupitemname.text = makeup!.title
            addbutton.setTitle("Update", for: .normal)
            deletebutton.isHidden = false
        } else{
            print("no game")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        makeupImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        
        
        
        
        if addbutton.currentTitle == "Add"{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let makeup = MakeUps(context: context)
            makeup.title = makeupitemname.text
            makeup.image = UIImagePNGRepresentation(makeupImageView.image!)! as NSData
            
        } else{
            makeup!.title = makeupitemname.text
            makeup!.image = UIImagePNGRepresentation(makeupImageView.image!)! as NSData
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(makeup!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
}
