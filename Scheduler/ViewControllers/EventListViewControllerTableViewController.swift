
import UIKit

class EventListViewController: UITableViewController {
    
    var eventArray = [Event]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Events.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEvents()
        
        
        // Do any additional setup after loading the view.
//        if let events = defaults.array(forKey: "eventsArray")as? [Event]{
//            eventArray = events
//        }
    }
    
    //Make the view for the Events
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style:.default,reuseIdentifier: "EventListCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath)
        
        let event = eventArray[indexPath.row]
        
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


   
    @IBAction func addEventBtn(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        var textField2 = UITextField()
        
        let alert = UIAlertController(title: "Create New Event", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Create Event", style: .default){ (action) in
            
            let newEvent = Event()
            let eventInfo = textField.text! + " @ " + textField2.text!
            newEvent.event = eventInfo
            
            self.eventArray.append(newEvent)
            self.saveEvents()

        }
        
        alert.addTextField{(eventName) in
            eventName.placeholder = "Name of event"
            textField = eventName
        }
        
        alert.addTextField{(eventLocation) in
            eventLocation.placeholder = "Location of event"
            textField2 = eventLocation
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
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
    
    func loadEvents(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            eventArray = try decoder.decode([Event].self, from: data)
            } catch {
                print("Error decoding event array, \(error)")
            }
        }
    }
    
}
