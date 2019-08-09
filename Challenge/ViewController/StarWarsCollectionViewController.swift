//
//  StarWarsCollectionViewController.swift
//  Challenge
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
        self.title = "APP"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.getInfo()
        self.setUpJSon()
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
    
    func setUpJSon() {
        let data = """
            [
  {
    "id": 1,
    "description": "Rebel Forces spotted on Hoth. Quell their rebellion for the Empire.",
    "title": "Stop Rebel Forces",
    "timestamp": "2015-06-18T17:02:02.614Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Battle_of_Hoth.jpg",
    "date": "2015-06-18T23:30:00.000Z",
    "locationline1": "Hoth",
    "locationline2": "Anoat System"
  },
  {
    "id": 2,
    "description": "All force-sensitive members of the Empire must report to the Sith Academy on Korriban. Test your passion, attain power, to defeat your enemy on the way to becoming a Dark Lord of the Sith",
    "title": "Sith Academy Orientation",
    "timestamp": "2015-06-18T21:52:42.865Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Korriban_Valley_TOR.jpg",
    "phone": "1 (800) 545-5334",
    "date": "2015-09-27T15:00:00.000Z",
    "locationline1": "Korriban",
    "locationline2": "Horuset System"
  },
  {
    "id": 3,
    "description": "There is trade dispute between the Trade Federation and the outlying systems of the Galactic Republic, which has led to a blockade of the small planet of Naboo. You must smuggle supplies and rations to citizens of Naboo through the blockade of Trade Federation Battleships",
    "title": "Run the Naboo Blockade",
    "timestamp": "2015-06-26T03:50:54.161Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Blockade.jpg",
    "phone": "1 (949) 172-0789",
    "date": "2015-07-12T19:08:00.000Z",
    "locationline1": "Naboo",
    "locationline2": "Naboo System"
  },
  {
    "id": 4,
    "description": "The Trade Federation has invaded Naboo and captured their leader, Queen Padmé Amidala. You must rescue her and her guard from the clutches of the Trade Defense Force. Process to the palace flight hangar to escape the planet in the Queen's starship",
    "title": "Rescue Queen Amidala",
    "timestamp": "2015-06-26T03:55:05.042Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/TPM_Cast.png",
    "phone": "1 (800) 325-5674",
    "date": "2015-09-08T15:07:00.000Z",
    "locationline1": "Naboo",
    "locationline2": "Naboo System"
  },
  {
    "id": 5,
    "description": "The Boonta Eve Classic us the largest annual podrace in the galaxy. Held on the planet of Tatooine, it is hosted by the Hutts to commemorate the Boonta's Eve holiday. Located just outside Mos Espa, the Boonta race course starts in the Mos Espa Grand Arena. Bring your podracer and nerves to win",
    "title": "Boonta Eve Classic",
    "timestamp": "2015-06-26T03:59:30.949Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Boonta_Eve_Podracers.png",
    "phone": "1 (800) 985-8694",
    "date": "2015-09-07T14:00:00.000Z",
    "locationline1": "Tatooine",
    "locationline2": "Tatoo System"
  },
  {
    "id": 6,
    "description": "In the Senate of the Galactic Republic, a Vote of No Confidence is a voting process in which senators remove the Supreme Chancellor from office due to a lack of majority support. Because of the invasion of Naboo ten years before the Clone Wars, the vote to end Chancellor Finis Valorum term has been put on the floor",
    "title": "Vote of No Confidence Senate Meeting",
    "timestamp": "2015-06-26T04:04:32.046Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Amidalabeforesenate.jpg",
    "phone": "1 (800) 235-0984",
    "date": "2015-08-09T15:00:00.000Z",
    "locationline1": "Coruscant",
    "locationline2": "Corusca Sector"
  },
  {
    "id": 7,
    "description": "Queen Padmé Amidala of the Naboo has formulated a plan to end the invasion, enlisting the help of the Gungan Grand Army to stage a diversion while the Queen battled to retake the planet's capitol and capture the Trade Federation's Viceroy, Nute Gunray.",
    "title": "Battle of Naboo",
    "timestamp": "2015-06-26T04:06:43.598Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/This_url_intentionally_404s_to_test_error_handling.jpg",
    "phone": "1 (800) 134-2344",
    "date": "2015-07-08T19:09:00.000Z",
    "locationline1": "Naboo",
    "locationline2": "Naboo System"
  },
  {
    "id": 8,
    "description": "In a Theed hangar bay, Darth Maul (an apprentice of the Sith Lord Sidious) has been engaging in combat with the two Jedi, using a double-bladed lightsaber. The battle moves from the hangar, across a series of catwalks, to the Theed Generator Complex.",
    "title": "Duel of the Fates",
    "timestamp": "2015-06-26T04:09:30.337Z",
    "image": null,
    "phone": "1 (800) 786-2430",
    "date": "2015-12-26T03:15:00.000Z",
    "locationline1": "Naboo",
    "locationline2": "Naboo System"
  },
  {
    "id": 9,
    "description": "After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks. After defeating the Sith, Darth Maul, Obi-Wan Kenobi will be taken his master's body to Theed and a traditional funeral will be held. Many Jedi will in attendance including Yoda, Mace Windu and several members of the Jedi High Council. As well as non-Jedi attendees which include Queen Amidala, Boss Rugor Nass, newly-elected Supreme Chancellor Palpatine, Anakin Skywalker, and Jar Jar Binks.",
    "title": "Funeral of Qui-Gon Jinn",
    "timestamp": "2015-06-26T04:14:24.732Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Qui-Gon's_funeral.png",
    "phone": "1 (800) 814-1988",
    "date": "2015-10-10T04:00:00.000Z",
    "locationline1": "Theed, Naboo",
    "locationline2": "Naboo System"
  },
  {
    "id": 10,
    "description": "The Battle of Naboo has been won! The Naboo and Gungans are organizing a great victory celebration that will take place on the streets of Theed, in front on the palace. Queen Amidala will be presenting a gift of appreciation and friendship to Boss Nass and the Gungan people.",
    "title": "Battle of Naboo Victory Celebration",
    "timestamp": "2015-06-26T04:17:04.381Z",
    "image": "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/Images/Naboo_celebration.jpg",
    "phone": "1 (800) 887-4208",
    "date": "2015-08-07T21:39:00.000Z",
    "locationline1": "Theed Palace, Naboo",
    "locationline2": "Naboo System"
  }
]
""".data(using: .utf8)! // our data in native (JSON) format
        
        if let starWars = try? JSONDecoder().decode([StoreStarWar].self, from: data) {
                self.saveStarWars(starWars: starWars)
                self.collectionView?.reloadData()
        }
    }
    
    func getInfo() {
        let url = URL(string: "")!
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

