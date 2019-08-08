//
//  StarWarsDetailTableViewController.swift
//  PhunChallenge
//
//  Created by Chang Choi on 8/3/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import UIKit

class StarWarsDetailTableViewController: UITableViewController {

    var starWar :StoreStarWar?
    
    @IBOutlet weak var starWarImageView: ImageLoader!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var location1Label: UILabel!
    @IBOutlet weak var location2Label: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDetails()
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            self.tableView.reloadData()
        }
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        self.shareActionInfo(sender)
    }
}

// Tableview Datasource & Delegate
extension StarWarsDetailTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            let screen = UIScreen.main.bounds
            let screenHeight = screen.size.height/3
            return screenHeight
        }
        return UITableView.automaticDimension
    }
}

private extension StarWarsDetailTableViewController {
    func setUpDetails() {
        self.tableView.tableFooterView = UIView()
        self.title = self.starWar?.title
        
        self.descriptionLabel.text = self.starWar?.descriptions
        self.dateLabel.text = self.starWar?.date
        self.titleLabel.text = self.starWar?.title
        self.location1Label.text = self.starWar?.locationline1
        self.location2Label.text = self.starWar?.locationline2
        self.phoneNumberLabel.text = self.starWar?.phone
    
        self.retrieveImage()
    }
    func retrieveImage() {
        let url = URL(string: self.starWar?.image ?? "")
        
        if let url = url {
            self.starWarImageView.loadImageWithUrl(url, storeStarWar: self.starWar!) { (inner: () throws -> Void) -> Void in
                do {
                    try inner()
                } catch let error {
                    // Error handling unavailable Image
                    DispatchQueue.main.async {
                        self.starWarImageView.image = UIImage(named: "placeHolder")
                    }
                    print(error)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else {
            // IMAGE URL IS NULL
            self.starWarImageView.image = UIImage(named: "placeHolder")
            self.tableView.reloadData()
        }
    }
    func shareActionInfo(_ sender: Any) {
        let image = self.starWarImageView.image ?? UIImage()
        let date = self.starWar?.date ?? ""
        let title = self.starWar?.title ?? ""
        let description = self.starWar?.descriptions ?? ""
        let location1 = self.starWar?.locationline1 ?? ""
        let location2 = self.starWar?.locationline2 ?? ""
        let phone = self.starWar?.phone ?? ""
        
        let activityViewController =
            UIActivityViewController(activityItems: [image, date, title, description, location1, location2, phone],
                                     applicationActivities: nil)
        
        present(activityViewController, animated: true) {}
        if let popOver = activityViewController.popoverPresentationController {
            popOver.barButtonItem = sender as? UIBarButtonItem
        } else {
            activityViewController.popoverPresentationController?.sourceView = self.view 
        }
    }
}
