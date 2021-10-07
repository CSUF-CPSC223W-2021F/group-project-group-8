//
//  Event.swift
//  Scheduler
//
//  Created by Henry on 9/23/21.
//

import Foundation

struct EventStruct {
    var eventName: String = ""
    var location: String = ""
    var date: String = ""
    var time: String = ""
    
    func makeEvent(eventName:String, location:String, date:String, time:String) -> String{
        
        var event = "Event name: \(eventName)\n We will be meeting at \(location) on \(date) at \(time)"
        return event
    }
}
