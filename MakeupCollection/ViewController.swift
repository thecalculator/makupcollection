//
//  ViewController.swift
//  MakeupCollection
//
//  Created by Shilpa Ghanmode on 8/3/17.
//  Copyright © 2017 com.tridev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var makeups : [MakeUps] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
        try makeups = context.fetch(MakeUps.fetchRequest())
        } catch {
            print("Error reading core data")
        }
        tableView.reloadData()

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = makeups[indexPath.row].title
        cell.imageView?.image = UIImage(data: makeups[indexPath.row].image! as Data)
        return cell
     
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "vieweditsegue", sender: makeups[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let nextVC = segue.destination as! AddItemsViewController
            nextVC.makeup = sender as? MakeUps
            
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makeups.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

