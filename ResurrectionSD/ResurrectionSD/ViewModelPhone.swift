//
//  ViewModelPhone.swift
//  ResurrectionSD
//
//  Created by Mohh Gupta on 4/5/21.
//

import Foundation
import WatchConnectivity

class ViewModelPhone : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    
    var recievedMessage = ""
    @Published var messageText = "1-2-3-4-5-6-7-8-9"
    var dataArray = ["1","2","3","4","5","6","7","8","9","10"]
    var recievedTime = 0.0
    var alarmTime = 0.0
    var trashTime = 0.0
    var previousRecievedTime = 0.0
    var iterationNumber = ""
    
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            DispatchQueue.main.async {
                self.messageText = message["message"] as? String ?? "Unknown"
            }
        self.dataArray = self.messageText.components(separatedBy: "-")
        iterationNumber = dataArray[9]
        print(dataArray)
        let alarming = Bool(dataArray[8]) ?? false
        if alarming {
            recievedTime = NSDate().timeIntervalSince1970
            previousRecievedTime = recievedTime
        } else {
            recievedTime = previousRecievedTime
        }
        
        print(messageText+"recieved by phone")
        
        }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}
