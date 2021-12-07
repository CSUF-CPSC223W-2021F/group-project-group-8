//
//  HomeViewController.swift
//  Scheduler
//
//  Created by Badillo, Nancy on 11/18/21.
//

import UIKit
import SwipeCellKit

class EventListViewController: UITableViewController{
    var eventArray = [Event]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Events.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEvents()

    }
    
    //Make the view for the Events
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style:.default,reuseIdentifier: "EventListCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        let event = eventArray[indexPath.row]
        
        //remove limit for number of lines
        cell.textLabel?.numberOfLines = 3
        
        cell.textLabel?.text = event.event
        // if dont is true set checkmark else set to none
        cell.accessoryType = event.done ? .checkmark : .none
        
        return cell
    }
    
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        eventArray[indexPath.row].done = !eventArray[indexPath.row].done
        
        saveEvents()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addBtn(_ sender: UIButton) {
        var name = UITextField()
        var location = UITextField()
        var date = UITextField()
        var time = UITextField()
        
        let alert = UIAlertController(title: "Create New Event", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Create Event", style: .default){ (action) in
            
            let newEvent = Event()
            let eventInfo =
            name.text! + "\n" + location.text! + "\n" + date.text! + " @ " + time.text!

            newEvent.event = eventInfo
            
            self.eventArray.append(newEvent)
            self.saveEvents()

        }
        
        alert.addTextField{(eventName) in
            eventName.placeholder = "Name"
            name = eventName
        }
        
        alert.addTextField{(eventLocation) in
            eventLocation.placeholder = "Location"
            location = eventLocation
        }
        
        alert.addTextField{(eventDate) in
            eventDate.placeholder = "Date"
            date = eventDate
        }
        
        alert.addTextField{(eventTime) in
            eventTime.placeholder = "Time"
            time = eventTime
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   //add functanality to the add button
    @IBAction func addEventBtn(_ sender: UIBarButtonItem) {
        
        var name = UITextField()
        var location = UITextField()
        var date = UITextField()
        var time = UITextField()
        
        let alert = UIAlertController(title: "Create New Event", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Create Event", style: .default){ (action) in
            
            let newEvent = Event()
            let eventInfo =
            name.text! + "\n" + location.text! + "\n" + date.text! + " @ " + time.text!

            newEvent.event = eventInfo
            
            self.eventArray.append(newEvent)
            self.saveEvents()

        }
        
        alert.addTextField{(eventName) in
            eventName.placeholder = "Name"
            name = eventName
        }
        
        alert.addTextField{(eventLocation) in
            eventLocation.placeholder = "Location"
            location = eventLocation
        }
        
        alert.addTextField{(eventDate) in
            eventDate.placeholder = "Date"
            date = eventDate
        }
        
        alert.addTextField{(eventTime) in
            eventTime.placeholder = "Time"
            time = eventTime
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
//save the events to local storage
    func saveEvents() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(eventArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error encoding event array, \(error)")
        }
        
        tableView.reloadData()
        
    }
//load the event from local storage
    func loadEvents(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            eventArray = try decoder.decode([Event].self, from: data)
            }catch {
                print("Error decoding event array, \(error)")
            }
        }
    }
    
}

// Swipe Cell Delegate Methods

extension EventListViewController: SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion

            self.eventArray.remove(at: indexPath.row)
            self.saveEvents()
            print("Item deleted")
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }

}
