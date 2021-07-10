//
//  ItemTableViewController.swift
//  Expo1900
//
//  Created by 편대호 on 2021/07/09.
//

import UIKit

class ItemTableViewController: UITableViewController {

    var itemName: String?
    var itemImage: UIImage?
    var itemDescrption: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = itemName
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { fatalError() }
        cell.itemImageView.image = itemImage
        cell.itemDescription.text = itemDescrption
        return cell
    }
   

}
