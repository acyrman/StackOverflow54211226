//
//  ViewController.swift
//  SO 54211226
//
//  Created by acyrman on 1/16/19.
//  Copyright © 2019 iCyrman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var quoteArray: [Quote] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteArray.count
    }
    
    fileprivate func displayAlert(_ text: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
            let alterAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(alterAction)
            self?.present(alert, animated: true)
        }
    }
    
    fileprivate func fetchJSON() {
        let urlString = "http://quotes.rest/qod.json?category=inspire"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if error != nil {
                self?.displayAlert("Error fetching data: \(String(describing: error?.localizedDescription))")
            }
            
            let decoder = JSONDecoder()
            do {
                guard let data = data else { throw NSError(domain: "this.app", code: -1, userInfo: nil) }

                let websiteObject = try decoder.decode(WebsiteObjectStruct.self, from: data)
                if let quotesArray = websiteObject.contents.quotes {
                    DispatchQueue.main.async {
                        self?.quoteArray = quotesArray
                        self?.tableView.reloadData()
                    }
                }
            } catch let error {
                self?.displayAlert("Error decoding json data: \(String(describing: error.localizedDescription))")
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let authorText = quoteArray[0].author ?? "Null author"
        let quoteText = quoteArray[0].quote ?? "Null quote"
        cell.textLabel?.text = authorText
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = quoteText
        //For quoteArray we are looking at zero index because in my JSON there
        // is ONLY EVER ONE element, located at index 0, in quoteArray
        return cell
    }
}
