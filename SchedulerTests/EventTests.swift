//
//  EventTests.swift
//  SchedulerTests
//
//  Created by Henry on 10/7/21.
//

import XCTest
@testable import Scheduler

class EventTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializer(){
        let myEvent = EventStruct(eventName:"study", location:"library", date:"10/08/21", time:"3:00 PM")
        XCTAssertEqual(myEvent.eventName, "study")
        XCTAssertEqual(myEvent.location, "library")
        XCTAssertEqual(myEvent.date, "10/08/21")
        XCTAssertEqual(myEvent.time, "3:00 PM")
    }
    
    func testEventPrint(){
        let myEvent = EventStruct(eventName:"study", location:"library", date:"10/08/21", time:"3:00 PM")
        myEvent.makeEvent()
        XCTAssertEqual(myEvent.makeEvent(), "Event name: study\n We will be meeting at library on 10/08/21 at 3:00 PM")

        
        
    }

}
