//
//  MyFellowsTableViewController.swift
//  GB_iOS_UI_Course
//
//  Created by Alexander Lezin on 23/05/2019.
//  Copyright © 2019 Alexander Lezin. All rights reserved.
//

import UIKit

class MyFellowsTableViewController: UITableViewController {

    let segueIdentifier = "ShowBadges"
   var fellows = [steveJobs, johnIve, timCook, vanJacobson]
    
    private var fellowsDic = [String: [Fellow]]()
    var fellowsChars: [String] {
        get {
            var chars = [String]()
            for fellow in self.fellows {
                if !chars.contains(fellow.fellowChar) {
                    chars.append(fellow.fellowChar)
                }
            }
            return chars.sorted()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fellows = fellows.sorted()
        
        // Appending fellows into dictionary
        for fellow in fellows {
            if var value = fellowsDic[fellow.fellowChar] {
                value.append(fellow)
                fellowsDic[fellow.fellowChar] = value
            } else {
                fellowsDic[fellow.fellowChar] = [fellow]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let destination = segue.destination as? BadgesCollectionViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let fellow = fellows[indexPath.row]
                    destination.fellowBadges = fellow.fellowBadges
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fellowsDic.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let key = self.fellowsChars[section]
        guard let numberOfRows = fellowsDic[key]?.count else {
            return 0
        }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fellowsChars[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Getting a cell from the pool
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFellowsCell", for: indexPath) as! MyFellowsTableViewCell
        // Getting certain fellow name
        let key = self.fellowsChars[indexPath.section]
        guard let fellow = fellowsDic[key] else { return cell }
        
        // Set course into cell lable
        cell.fellowLabel.text = fellow[indexPath.row].fellowFullName
        cell.fellowAvatar.createAvatar(fellow[indexPath.row].fellowAvatar)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
