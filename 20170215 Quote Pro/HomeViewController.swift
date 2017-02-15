//
//  HomeViewController.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var quoteTableView: UITableView!
    let manager: DataManager
    var quoteArray: [QuoteObject]?

    required init?(coder aDecoder: NSCoder) {
        manager = DataManager.sharedInstance
        quoteArray = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        quoteArray = manager.getQuotes()
        quoteTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let quoteArray = quoteArray {
            return quoteArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quoteTableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as! QuoteTableViewCell
        guard let quoteArray = quoteArray else {
            return cell
        }
        cell.quoteLabel.text = quoteArray[indexPath.row].quote
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
