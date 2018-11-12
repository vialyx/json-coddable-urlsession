//
//  Database.swift
//  JsonCoddableUrlSession
//
//  Created by Maksim Vialykh on 12/11/2018.
//  Copyright © 2018 Vialyx. All rights reserved.
//

import Foundation
import RealmSwift

// TODO: - Move to the separated file Flight.swift (Realm folder)
class Flight: Object {
    @objc dynamic var airline: String = ""
    @objc dynamic var flight: String = ""
    @objc dynamic var actualTime: String = ""
    
    override static func primaryKey() -> String? {
        return "flight"
    }
    
}

final class Database {
    
    func save(flights: [FlightData]) {
        let realm = try! Realm()
        try! realm.write {
            flights.forEach { flight in
                let object = Flight()
                object.airline = flight.Airline
                object.flight = flight.Flight
                object.actualTime = flight.ActualTime
                realm.add(object, update: true)
            }
        }
    }
    
    func get() -> [FlightData] {
        let realm = try! Realm()
        return realm.objects(Flight.self).map { object in
            return FlightData(Airline: object.airline,
                              Flight: object.flight,
                              ActualTime: object.actualTime)
        }
    }
    
}
