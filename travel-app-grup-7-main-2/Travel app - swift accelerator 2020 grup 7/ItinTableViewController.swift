//
//  ItinTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 27/11/20.
//

import UIKit

class ItinTableViewController: UITableViewController {
    let schedule = ["Jan 3, 2020", "Mar 27, 2020"]
    var interval: Int = 0
    var daysDictionary: Dictionary<Int, Any> = [:]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Itinerary"
        interval = getDateInterval(shedule: self.schedule)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        print("daysDictionary VDA:", daysDictionary)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return interval
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinCell", for: indexPath)
        cell.textLabel?.text = "Day \(String(indexPath.row+1))"
        cell.detailTextLabel?.text = generateDate(schedule: self.schedule, dayNumber: indexPath.row)
        // Configure the cell...

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDayDetail"{
                if let dest = segue.destination as? ItinEventsTableViewController{
                    print("segue showDayDetail performed")
                    let indexPath = tableView.indexPathForSelectedRow!
                    dest.dayNo = indexPath.row
                    print("dayNo:", indexPath.row)
                    print("Not nil true")
                    dest.events = daysDictionary[indexPath.row] as? Array<DayEvent> ?? []
                    print("daysDictionary:", daysDictionary[indexPath.row]!)
                    }
            }
        }

    
    func getDateInterval(shedule: [String]) -> Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd, yyyy"
        let dateStart = formatter.date(from: schedule[0])!
        let dateEndTemp = formatter.date(from: schedule[1])!
        let dateEnd = dateEndTemp.addingTimeInterval(TimeInterval(60 * 60 * 24))
        let interval = Int( dateEnd.timeIntervalSince(dateStart)/(24.0*60.0*60.0))
        print("interval:", interval)
        return interval
    }
    
    func generateDate(schedule: [String], dayNumber: Int) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd, yyyy"
        let dateStart = formatter.date(from: schedule[0])!
        let dateMiddle = dateStart.addingTimeInterval(TimeInterval(dayNumber * 60 * 60 * 24))
        let formatter2 = DateFormatter()
        formatter2.dateStyle = .medium
        formatter2.timeStyle = .none
        let day = formatter2.string(from: dateMiddle)
        print("day:", day)
        
        return day
    }
    
    @IBAction func unwindToItinTableViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
