//
//  StarWarsCollectionViewController.swift
//  PhunChallenge
//
//  Created by Chang Choi on 8/3/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "starwarsCell"

class StarWarsCollectionViewController: UICollectionViewController {
    
    var starWarsArray :[StoreStarWar]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "PHUN APP"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getInfo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
        super.viewWillDisappear(animated)
    }
 
    // Upside down portrait mode
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .all
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let starWarsDetailController = segue.destination as? StarWarsDetailTableViewController else {
            fatalError()
        }
        
        if segue.identifier == "detailsSegue" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                
                let starWar = self.starWarsArray?[indexPath.row]
                let sendStarWar = StoreStarWar(starwar: starWar!)
                starWarsDetailController.starWar = sendStarWar
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.starWarsArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarWarsCollectionViewCell.identifier, for: indexPath) as? StarWarsCollectionViewCell
            else { preconditionFailure("Failed to load collection view cell") }
        
        cell.starWar = self.starWarsArray?[indexPath.item]
        
        return cell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailsSegue", sender: self)
    }
  
}
// Networking
extension StarWarsCollectionViewController {
    func getInfo() {
        let url = URL(string: "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                // Show locally stored StarWars
                self.getStoredStarWars()
                return
            }
            if let data = data {
                if let starWars = try? JSONDecoder().decode([StoreStarWar].self, from: data) {

                    DispatchQueue.main.async {
                        self.saveStarWars(starWars: starWars)
                        self.collectionView?.reloadData()
                    }
                } else {
                    //handle starwars' data = nil
                    self.getStoredStarWars()
                }
            }
        }
        task.resume()
    }
    func saveStarWars(starWars: [StoreStarWar]) {
        let realm = try! Realm()
        try! realm.write {
            let result = realm.objects(StoreStarWar.self)
            realm.delete(result) // Delete all StoredStarWar to update new StoreStarWar Objects
            
            for starWar in starWars {
                realm.add(starWar) // Save StoreStarWar Objects
            }
        }
        self.getStoredStarWars()
    }
    func getStoredStarWars() {
        DispatchQueue.main.async {
            let realm = try! Realm()
            let result = realm.objects(StoreStarWar.self) // Retrieve StoreStarWar objects

            if result.count > 0 {
                self.starWarsArray = [StoreStarWar]()
                self.starWarsArray = Array(result)
            }
            self.collectionView.reloadData()
        }
    }
}

