//
//  ViewController.swift
//  KeeponTrack3
//
//  Created by Navadeep Budda on 6/5/21.
//

import UIKit
import EventKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        var host = "10.0.0.2:5000/getEvents"
        var running = True

        while running == True(
            if let url = URL(string: host) {
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                if error == nil {
                    if data != nil {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Double] {
                            DispatchQueue.main.async {
                                
                                if let usdPrice = json["USD"] {
                                    self.usdLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                                    UserDefaults.standard.set(self.getStringFor(price: usdPrice, currencyCode: "USD") + "~", forKey: "USD")
                                }
                                if let eurPrice = json["EUR"] {
                                    self.eurLabel.text = self.getStringFor(price: eurPrice, currencyCode: "EUR")
                                    UserDefaults.standard.set(self.getStringFor(price: eurPrice, currencyCode: "EUR") + "~", forKey: "EUR")
                                }
                                if let jpyPrice = json["JPY"] {
                                    self.jpyLabel.text = self.getStringFor(price: jpyPrice, currencyCode: "JPY")
                                    UserDefaults.standard.set(self.getStringFor(price: jpyPrice, currencyCode: "JPY") + "~", forKey: "JPY")
                                }
                                
                            }
                        }
                    }
                    
                    
                } else {
                    print("We have an error")
                }
            }.resume()
        }
        )
        
        // 1
        let eventStore = EKEventStore()
            
        // 2
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            insertEvent(store: eventStore)
            case .denied:
                print("Access denied")
            case .notDetermined:
            // 3
                eventStore.requestAccess(to: .event, completion:
                  {[weak self] (granted: Bool, error: Error?) -> Void in
                      if granted {
                        self!.insertEvent(store: eventStore)
                      } else {
                            print("Access denied")
                      }
                })
                default:
                    print("Case default")
        }
    }
    
    func insertEvent(store: EKEventStore) {
        // 1
        let calendars = store.calendars(for: .event)
            
        for calendar in calendars {
            // 2
            if calendar.title == "ioscreator" {
                // 3
                let startDate = Date()
                // 2 hours
                let endDate = startDate.addingTimeInterval(2 * 60 * 60)
                    
                // 4
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                    
                event.title = "New Meeting"
                event.startDate = startDate
                event.endDate = endDate
                    
                // 5
                do {
                    try store.save(event, span: .thisEvent)
                }
                catch {
                   print("Error saving event in calendar")             }
                }
        }
    }


}

