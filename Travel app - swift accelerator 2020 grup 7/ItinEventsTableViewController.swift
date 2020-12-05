//
//  ItinTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 27/11/20.
//

import UIKit

class ItinEventsTableViewController: UITableViewController {
    var dayNo: Int = 0
    var events: Array<DayEvent> = [DayEvent(destination: "Bali", timeStart: "16:00", timeEnd: "17:00", date: "Jan 5, 2020", notes:"")]
    var eventNo: Int = 0
    var delegate: DataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("dayNo:", dayNo)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinEventCell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row].destination
        let text = "\(events[indexPath.row].timeStart) - \(events[indexPath.row].timeEnd)"
        cell.detailTextLabel?.text = text
        eventNo = indexPath.row

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
        if segue.identifier == "eventsToEventDetail"{
            if let dest = segue.destination as? ItinEventViewController{
                dest.eventNo = eventNo
                dest.event = events[eventNo]
            }
        }
        if segue.identifier == "eventsToNewEvent"{
            if let dest = segue.destination as? ItinEventViewController{
                dest.isAnExistingEvent = false
        }
    }
        if segue.identifier == "backToItineraryTableViewController"{
            if let dest = segue.destination as? ItinTableViewController{
                dest.dayDictionary[dayNo] = events
//                dest.tempEvents = events
            }
        }
    }
    
    
    @IBAction func backToItinEventsTableViewController (with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinEventViewController{
            if source.isAnExistingEvent == true{
                events[eventNo] = source.event

                tableView.reloadData()
            }else{
                switch source.event {
                case nil:
                    print("adding event cancelled")
                default:
                    events.append(source.event)
                    tableView.reloadData()
                }
            }
        }
    }

}
