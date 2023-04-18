//
//  ContentView.swift
//  ResurrectionSD WatchKit Extension
//
//  Created by Mohh Gupta on 4/5/21.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    
    // MARK: - Parameters
    var model = ViewModelWatch()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let vitalData : [VitalData] = Bundle.main.decode("23_min_trial.json")
    @State var currentTime = 0.0
    //Vital Signs
    @State var i = 0
    @State var hr1 = 5
    @State var oxi1 = 5
    @State var bps1 = 5
    @State var bpd1 = 5
    
    @State var currentAlarm = false
    @State var previousAlarm = false
    @State var alarming = false
    
    @State var hr2 = 5
    @State var oxi2 = 5
    @State var bps2 = 5
    @State var bpd2 = 5
    
    @State var hr1last = 5
    @State var oxi1last = 5
    @State var bps1last = 5
    @State var bpd1last = 5
    
    @State var hr2last = 5
    @State var oxi2last = 5
    @State var bps2last = 5
    @State var bpd2last = 5
    
    //Arrow directions
    @State var hr1Arrow = "arrow.right"
    @State var hr2Arrow = "arrow.right"
    
    @State var oxi1Arrow = "arrow.right"
    @State var oxi2Arrow = "arrow.right"
    
    @State var bp1Arrow = "arrow.right"
    @State var bp2Arrow = "arrow.right"
    
    //Background Golor
    @State var hr1Color = Color.black
    @State var hr2Color = Color.black
    
    @State var oxi1Color = Color.black
    @State var oxi2Color = Color.black
    
    @State var bp1Color = Color.black
    @State var bp2Color = Color.black
    
    //Stroke Color
    @State var hr1Border = Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1))
    @State var hr2Border = Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1))
    @State var oxi1Border = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    @State var oxi2Border = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    @State var bp1Border = Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1))
    @State var bp2Border = Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1))
    
    // Gradation Colors
    let upperColor = Color(#colorLiteral(red: 0.8562226295, green: 0, blue: 0.348115027, alpha: 1))
    let upperMidColor = Color(#colorLiteral(red: 1, green: 0.458945632, blue: 0.1288162172, alpha: 1))
    let defaultColor = Color(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1))
    let lowerMidColor = Color(#colorLiteral(red: 0, green: 0.8714541793, blue: 1, alpha: 1))
    let lowerColor = Color(#colorLiteral(red: 0.1417264044, green: 0.157099098, blue: 1, alpha: 1))
    
    // Gradation Thresholds
        //Cardio
        let upperHR = 110.0
        let upperMidHR = 90.0
        let lowerMidHR = 65.0
        let lowerHR = 50.0
    
        //Oxi
        let upperOxi = 100.0
        let upperMidOxi = 100.0
        let lowerMidOxi = 92.0
        let lowerOxi = 88.0
    
        //BP
        let upperBP = 160.0
        let upperMidBP = 140.0
        let lowerMidBP = 100.0
        let lowerBP = 80.0
    
    // Arrow Thresholds
    let timeWindow = 15.0
    let upperArrowThresh = 0.40
    let upperMidArrowThresh = 0.10
    let lowerMidArrowThresh = -0.10
    let lowerArrowThresh = -0.40
    
    
    //Logiv Array Thresholds
    @State var hr1Arr = [Double](repeating: 0.0, count: 15)
    @State var hr2Arr = [Double](repeating: 0.0, count: 15)
    @State var oxi1Arr = [Double](repeating: 0.0, count: 15)
    @State var oxi2Arr = [Double](repeating: 0.0, count: 15)
    @State var bp1Arr = [Double](repeating: 0.0, count: 15)
    @State var bp2Arr = [Double](repeating: 0.0, count: 15)
    
    //Alarm Thresholds
    var cardioAlarmThreshold = 130
    
    let lineWidth = 4
    let cornerRad = 10
    
    //@State var messageText = "message"
    
    // MARK: - Functions
    
    
    
    
        // MARK: Cardio Alarm
    func cardioAlarm(vitalSign:[Double], prevAvArray1:[Double],prevAvArray2:[Double]) -> (currentAvArray1:[Double],currentAvArray2:[Double], arrowDirection1: String, arrowDirectoin2: String) {
        
        
        let patient1 = vitalSign[0]
        let patient2 = vitalSign[1]
        var arrowDirection1 = ""
        var arrowDirection2 = ""
        
        // Alarm
        if (patient1 > upperHR) && (patient2 > upperHR){
            
                WKInterfaceDevice.current().play(.success)
                playSound(sound: "cardiovascular", type: "wav")
                withAnimation{
                    hr1Color = Color.red
                    hr2Color = Color.red
                }
            currentAlarm = true
            
        }
        if (patient1 < lowerHR) && (patient2 < lowerHR){
            
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "cardiovascular", type: "wav")
            withAnimation{
                hr1Color = Color.red
                hr2Color = Color.red
            }
            currentAlarm = true
        }
        
        if (patient1 > upperHR) {
            WKInterfaceDevice.current().play(.success) 
            playSound(sound: "cardiovascular", type: "wav")
            withAnimation{
                hr1Color = Color.red
            }
            currentAlarm = true
            
        }
        
        if (patient2 > upperHR) {
            WKInterfaceDevice.current().play(.success)
            playSound(sound: "cardiovascular", type: "wav")
            withAnimation{
                hr2Color = Color.red
            }
            currentAlarm = true
            
        }
        
        if (patient1 < lowerHR) {
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "cardiovascular", type: "wav")
            withAnimation{
                hr1Color = Color.red
            }
            currentAlarm = true
            
        }
        
        if (patient2 < lowerHR) {
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "cardiovascular", type: "wav")
            withAnimation{
                hr2Color = Color.red
            }
            currentAlarm = true
            
        }
        
        
        // Patient 1 Arrow Direction
        let sum1 = prevAvArray1.reduce(0,+)
        let prevAvg1 = sum1/timeWindow
        var currentAvArray1 = prevAvArray1[0...(Int(timeWindow-1))]
        currentAvArray1 += [patient1]
        let sum11 = currentAvArray1.reduce(0,+)
        let currentAvg1 = sum11/timeWindow
        
        let diff1 = (currentAvg1-prevAvg1)/currentAvg1
        
        if diff1 >  upperArrowThresh {
             arrowDirection1 = "arrow.up"
            //print(arrow)
        }
        else if diff1 > upperMidArrowThresh {
             arrowDirection1 = "arrow.up.right"
            //print(arrow)
        }
        else if diff1 < lowerMidArrowThresh {
             arrowDirection1 = "arrow.down.right"
            //print(arrow)
        }
        else if diff1 < lowerArrowThresh {
             arrowDirection1 = "arrow.down"
           // print(arrow)
        }
        else {
            arrowDirection1 = "arrow.right"
            //print(arrow)
        }
        // Patient 1 Gradation
        if patient1 >= upperHR {
            hr1Border = upperColor
        } else if (patient1 < upperHR) && (patient1 >= upperMidHR){
            hr1Border = upperMidColor
        } else if (patient1 < upperMidHR) && (patient1 >= lowerMidHR) {
            hr1Border = defaultColor
        } else if (patient1 < lowerMidHR) && (patient1 >= lowerHR){
            hr1Border = lowerMidColor
        } else {
            hr1Border = lowerColor
        }
            
        
    
        let sum2 = prevAvArray2.reduce(0,+)
        let prevAvg2 = sum2/timeWindow
        var currentAvArray2 = prevAvArray2[0...(Int(timeWindow-1))]
        currentAvArray2 += [patient2]
        let sum22 = currentAvArray2.reduce(0,+)
        let currentAvg2 = sum22/timeWindow
        
        let diff2 = currentAvg2-prevAvg2
        if diff2 >  upperArrowThresh {
             arrowDirection2 = "arrow.up"
            //print(arrow)
        }
        else if diff2 > upperMidArrowThresh {
             arrowDirection2 = "arrow.up.right"
            //print(arrow)
        }
        else if diff2 < lowerMidArrowThresh {
             arrowDirection2 = "arrow.down.right"
            //print(arrow)
        }
        else if diff2 < lowerArrowThresh {
             arrowDirection2 = "arrow.down"
           // print(arrow)
        }
        else {
            arrowDirection2 = "arrow.right"
            //print(arrow)
        }
        
        
        if patient2 >= upperHR {
            hr2Border = upperColor
        } else if (patient2 < upperHR) && (patient2 >= upperMidHR){
            hr2Border = upperMidColor
        } else if (patient2 < upperMidHR) && (patient2 >= lowerMidHR) {
            hr2Border = defaultColor
        } else if (patient2 < lowerMidHR) && (patient2 >= lowerHR){
            hr2Border = lowerMidColor
        } else {
            hr2Border = lowerColor
        }
        
        return (Array(currentAvArray1),Array(currentAvArray2),arrowDirection1,arrowDirection2)
        
        
    }
    
    // MARK: Oxi Alarm
    func oxiAlarm(vitalSign:[Double], prevAvArray1:[Double],prevAvArray2:[Double]) -> (currentAvArray1:[Double],currentAvArray2:[Double], arrowDirection1: String, arrowDirectoin2: String) {
        
        
        let patient1 = vitalSign[0]
        let patient2 = vitalSign[1]
        var arrowDirection1 = ""
        var arrowDirection2 = ""
        
        // Alarm
        /*if (patient1 > 130) && (patient2 > 130){
            WKInterfaceDevice.current().play(.success)
            playSound(sound: "high", type: "wav")
            withAnimation{
                oxi1Color = Color.red
            }
        }*/
        
        if (patient1 < lowerOxi) && (patient2 < lowerOxi){
                
                WKInterfaceDevice.current().play(.failure)
                playSound(sound: "oxygenation", type: "wav")
                
                withAnimation{
                    oxi1Color = Color.red
                    oxi2Color = Color.red
                }
            currentAlarm = true
            
        }
        
        if (patient1 < lowerOxi) {
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "oxygenation", type: "wav")
            withAnimation{
                oxi1Color = Color.red
            }
            currentAlarm = true
        }
        
        if (patient2 < lowerOxi) {
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "oxygenation", type: "wav")
            withAnimation{
                oxi2Color = Color.red
            }
            
            currentAlarm = true
        }
        
        
        // Patient 1 Arrow Direction
        let sum1 = prevAvArray1.reduce(0,+)
        let prevAvg1 = sum1/timeWindow
        var currentAvArray1 = prevAvArray1[0...(Int(timeWindow-1))]
        currentAvArray1 += [patient1]
        let sum11 = currentAvArray1.reduce(0,+)
        let currentAvg1 = sum11/timeWindow
        
        let diff1 = (currentAvg1-prevAvg1)/currentAvg1
        
        if diff1 >  upperArrowThresh {
             arrowDirection1 = "arrow.up"
            //print(arrow)
        }
        else if diff1 > upperMidArrowThresh {
             arrowDirection1 = "arrow.up.right"
            //print(arrow)
        }
        else if diff1 < lowerMidArrowThresh {
             arrowDirection1 = "arrow.down.right"
            //print(arrow)
        }
        else if diff1 < lowerArrowThresh {
             arrowDirection1 = "arrow.down"
           // print(arrow)
        }
        else {
            arrowDirection1 = "arrow.right"
            //print(arrow)
        }
        // Patient 1 Gradation
       if (patient1 >= lowerMidOxi) {
            oxi1Border  = defaultColor
        } else if (patient1 < lowerMidOxi) && (patient1 >= lowerOxi){
            oxi1Border  = lowerMidColor
        } else {
            oxi1Border  = lowerColor
        }
            
        
    
        let sum2 = prevAvArray2.reduce(0,+)
        let prevAvg2 = sum2/timeWindow
        var currentAvArray2 = prevAvArray2[0...(Int(timeWindow-1))]
        currentAvArray2 += [patient2]
        let sum22 = currentAvArray2.reduce(0,+)
        let currentAvg2 = sum22/timeWindow
        
        let diff2 = currentAvg2-prevAvg2
        if diff2 >  upperArrowThresh {
             arrowDirection2 = "arrow.up"
            //print(arrow)
        }
        else if diff2 > upperMidArrowThresh {
             arrowDirection2 = "arrow.up.right"
            //print(arrow)
        }
        else if diff2 < lowerMidArrowThresh {
             arrowDirection2 = "arrow.down.right"
            //print(arrow)
        }
        else if diff2 < lowerArrowThresh {
             arrowDirection2 = "arrow.down"
           // print(arrow)
        }
        else {
            arrowDirection2 = "arrow.right"
            //print(arrow)
        }
        
        
        if (patient2 >= lowerMidOxi) {
             oxi2Border  = defaultColor
         } else if (patient2 < lowerMidOxi) && (patient2 >= lowerOxi){
             oxi2Border  = lowerMidColor
         } else {
             oxi2Border  = lowerColor
         }
        
        oxi1Color = Color.black
        oxi2Color = Color.black
        print(oxi1Border)
        
        return (Array(currentAvArray1),Array(currentAvArray2),arrowDirection1,arrowDirection2)
        
        
    }
    
    // MARK: BP Alarm
    func bpAlarm(vitalSign:[Double], prevAvArray1:[Double],prevAvArray2:[Double]) -> (currentAvArray1:[Double],currentAvArray2:[Double], arrowDirection1: String, arrowDirectoin2: String) {
        
        
        let patient1 = vitalSign[0]
        let patient2 = vitalSign[1]
        var arrowDirection1 = ""
        var arrowDirection2 = ""
        
        // Alarm
        if (patient1 > upperBP) && (patient2 > upperBP){
            WKInterfaceDevice.current().play(.success)
            playSound(sound: "high", type: "wav")
            withAnimation{
                bp1Color = Color.red
                bp2Color = Color.red
            }
            currentAlarm = true
        }
        
        if (patient1 > upperBP){
            WKInterfaceDevice.current().play(.success)
            playSound(sound: "high", type: "wav")
            withAnimation{
                bp1Color = Color.red
            }
            currentAlarm = true
        }
        
        if (patient2 > upperBP){
            WKInterfaceDevice.current().play(.success)
           playSound(sound: "high", type: "wav")
            withAnimation{
                bp2Color = Color.red
            }
            currentAlarm = true
        }
        
        if (patient1 < lowerBP) && (patient2 < lowerBP){
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "high", type: "wav")
            withAnimation{
                bp1Color = Color.red
                bp2Color = Color.red
            }
            currentAlarm = true
        } else if (patient1 < lowerBP){
            WKInterfaceDevice.current().play(.failure)
           playSound(sound: "high", type: "wav")
            withAnimation{
                bp1Color = Color.red
            }
            currentAlarm = true
        } else if (patient2 < lowerBP){
            WKInterfaceDevice.current().play(.failure)
            playSound(sound: "high", type: "wav")
            withAnimation{
                bp2Color = Color.red
            }
            currentAlarm = true
        }
        
        
        // Patient 1 Arrow Direction
        let sum1 = prevAvArray1.reduce(0,+)
        let prevAvg1 = sum1/timeWindow
        var currentAvArray1 = prevAvArray1[0...(Int(timeWindow-1))]
        currentAvArray1 += [patient1]
        let sum11 = currentAvArray1.reduce(0,+)
        let currentAvg1 = sum11/timeWindow
        
        let diff1 = (currentAvg1-prevAvg1)/currentAvg1
        
        if diff1 >  upperArrowThresh {
             arrowDirection1 = "arrow.up"
            //print(arrow)
        }
        else if diff1 > upperMidArrowThresh {
             arrowDirection1 = "arrow.up.right"
            //print(arrow)
        }
        else if diff1 < lowerMidArrowThresh {
             arrowDirection1 = "arrow.down.right"
            //print(arrow)
        }
        else if diff1 < lowerArrowThresh {
             arrowDirection1 = "arrow.down"
           // print(arrow)
        }
        else {
            arrowDirection1 = "arrow.right"
            //print(arrow)
        }
        // Patient 1 Gradation
        if patient1 >= upperBP {
            bp1Border = upperColor
        } else if (patient1 < upperBP) && (patient1 >= upperMidBP){
            bp1Border = upperMidColor
        } else if (patient1 < upperMidBP) && (patient1 >= lowerMidBP) {
            bp1Border = defaultColor
        } else if (patient1 < lowerMidBP) && (patient1 >= lowerBP){
            bp1Border = lowerMidColor
        } else {
            bp1Border = lowerColor
        }
            
        
    
        let sum2 = prevAvArray2.reduce(0,+)
        let prevAvg2 = sum2/timeWindow
        var currentAvArray2 = prevAvArray2[0...(Int(timeWindow-1))]
        currentAvArray2 += [patient2]
        let sum22 = currentAvArray2.reduce(0,+)
        let currentAvg2 = sum22/timeWindow
        
        let diff2 = currentAvg2-prevAvg2
        if diff2 >  upperArrowThresh {
             arrowDirection2 = "arrow.up"
            //print(arrow)
        }
        else if diff2 > upperMidArrowThresh {
             arrowDirection2 = "arrow.up.right"
            //print(arrow)
        }
        else if diff2 < lowerMidArrowThresh {
             arrowDirection2 = "arrow.down.right"
            //print(arrow)
        }
        else if diff2 < lowerArrowThresh {
             arrowDirection2 = "arrow.down"
           // print(arrow)
        }
        else {
            arrowDirection2 = "arrow.right"
            //print(arrow)
        }
        
        
        if patient2 >= upperBP {
            bp2Border = upperColor
        } else if (patient2 < upperBP) && (patient2 >= upperMidBP){
            bp2Border = upperMidColor
        } else if (patient2 < upperMidBP) && (patient2 >= lowerMidBP) {
            bp2Border = defaultColor
        } else if (patient2 < lowerMidBP) && (patient2 >= lowerBP){
            bp2Border = lowerMidColor
        } else {
            bp2Border = lowerColor
        }
        
        return (Array(currentAvArray1),Array(currentAvArray2),arrowDirection1,arrowDirection2)
        
        
    }
    
    
    
    
    
    
    // MARK: - Interface
    
    var body: some View {
        GeometryReader { geo in
            let vitalWidth = geo.size.width*2/5
            let iconWidth = geo.size.width/5
            let vitalHeight = geo.size.height/3
            HStack(spacing:0){
                // MARK: Patient 1
                VStack() {
                    
                    VitalInfo(vital: hr1, type: "hr", arrowDirection: hr1Arrow)
                        //.clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    //.strokeBorder())
                        .frame(width: vitalWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background( RoundedRectangle(cornerRadius: 8).strokeBorder(hr1Border,lineWidth: CGFloat(lineWidth)))
                        .animation(nil)
                        /*.overlay(
                                RoundedRectangle(cornerRadius:CGFloat(cornerRad) )
                                    .strokeBorder(Color.blue, lineWidth: CGFloat(lineWidth))
                            )*/
                        .background(hr1Color)
                        .animation(
                            Animation.easeInOut(duration: 0.3).repeatCount(5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    VitalInfo(vital: oxi1, type: "oxi", arrowDirection: oxi1Arrow)
                        .frame(width: vitalWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background( RoundedRectangle(cornerRadius: 8).strokeBorder(oxi1Border,lineWidth: CGFloat(lineWidth)))
                        .animation(nil)
                        /*.overlay(
                                RoundedRectangle(cornerRadius:CGFloat(cornerRad) )
                                    .strokeBorder(Color.blue, lineWidth: CGFloat(lineWidth))
                            )*/
                        .background(oxi1Color)
                        .animation(
                            Animation.easeInOut(duration: 0.3).repeatCount(5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    BPView(sys: bps1, dia: bpd1, arrowDirection: bp1Arrow)
                        .frame(width: vitalWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background( RoundedRectangle(cornerRadius: 8).strokeBorder(bp1Border,lineWidth: CGFloat(lineWidth)))
                        .animation(nil)
                        /*.overlay(
                                RoundedRectangle(cornerRadius:CGFloat(cornerRad) )
                                    .strokeBorder(Color.blue, lineWidth: CGFloat(lineWidth))
                            )*/
                        .background(bp1Color)
                        .animation(
                            Animation.easeInOut(duration: 0.3).repeatCount(5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                VStack {
                    // MARK: - Middle Bar
                    Image(systemName: "heart")
                        .frame(width: iconWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(.system(size:20))
                    Image(systemName: "lungs.fill")
                        .frame(width: iconWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(.system(size:20))
                    Image(systemName: "barometer")
                        .frame(width: iconWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(.system(size:20))
                }
                VStack {
                    // MARK: - Patient 2
                    VitalInfo(vital: hr2, type: "hr", arrowDirection: hr2Arrow)
                        .frame(width: vitalWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background( RoundedRectangle(cornerRadius: 8).strokeBorder(hr2Border,lineWidth: CGFloat(lineWidth)))
                        .animation(nil)
                        /*.overlay(
                                RoundedRectangle(cornerRadius:CGFloat(cornerRad) )
                                    .strokeBorder(Color.blue, lineWidth: CGFloat(lineWidth))
                            )*/
                        .background(hr2Color)
                        .animation(
                            Animation.easeInOut(duration: 0.3).repeatCount(5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    VitalInfo(vital: oxi2, type: "oxi", arrowDirection: oxi2Arrow)
                        .frame(width: vitalWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background( RoundedRectangle(cornerRadius: 8).strokeBorder(oxi2Border,lineWidth: CGFloat(lineWidth)))
                        .animation(nil)
                        /*.overlay(
                                RoundedRectangle(cornerRadius:CGFloat(cornerRad) )
                                    .strokeBorder(Color.blue, lineWidth: CGFloat(lineWidth))
                            )*/
                        .background(oxi2Color)
                        .animation(
                            Animation.easeInOut(duration: 0.3).repeatCount(5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    BPView(sys: bps2, dia: bpd2, arrowDirection: bp2Arrow)
                        .frame(width: vitalWidth, height: vitalHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background( RoundedRectangle(cornerRadius: 8).strokeBorder(bp2Border,lineWidth: CGFloat(lineWidth)))
                        .animation(nil)
                        /*.overlay(
                                RoundedRectangle(cornerRadius:CGFloat(cornerRad) )
                                    .strokeBorder(Color.blue, lineWidth: CGFloat(lineWidth))
                            )*/
                        .background(bp2Color)
                        .animation(
                            Animation.easeInOut(duration: 0.3).repeatCount(5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        // MARK: - Logic
        .onReceive(timer, perform: { time in
            //print(vitalData[0].id)
            
            
            hr1 = vitalData[0].hr1[self.i]
            hr2 = vitalData[0].hr2[self.i]
            
            oxi1 = vitalData[0].oxi1[self.i]
            oxi2 = vitalData[0].oxi2[self.i]
            
            bps1 = vitalData[0].bps1[self.i]
            bps2 = vitalData[0].bps2[self.i]
            
            bpd1 = vitalData[0].bpd1[self.i]
            bpd2 = vitalData[0].bpd2[self.i]
            
            print(oxi1)
            
            
            let hrOut = cardioAlarm(vitalSign: [Double(hr1),Double(hr2)], prevAvArray1: hr1Arr, prevAvArray2: hr2Arr)
                        
            //print(hrOut.arrowDirection)
                        
            self.hr1Arr = hrOut.currentAvArray1
            self.hr2Arr = hrOut.currentAvArray2
            self.hr1Arrow = hrOut.arrowDirection1
            self.hr2Arrow = hrOut.arrowDirectoin2
            
            let oxiOut = oxiAlarm(vitalSign: [Double(oxi1),Double(oxi2)], prevAvArray1: oxi1Arr, prevAvArray2: oxi2Arr)
            
            self.oxi1Arr = oxiOut.currentAvArray1
            self.oxi2Arr = oxiOut.currentAvArray2
            self.oxi1Arrow = oxiOut.arrowDirection1
            self.oxi2Arrow = oxiOut.arrowDirectoin2
            
            let bpOut = bpAlarm(vitalSign: [Double(bps1),Double(bps2)], prevAvArray1: bp1Arr, prevAvArray2: bp2Arr)
            
            self.bp1Arr = bpOut.currentAvArray1
            self.bp2Arr = bpOut.currentAvArray2
            self.bp1Arrow = bpOut.arrowDirection1
            self.bp2Arrow = bpOut.arrowDirectoin2
            
            hr1Color = Color.black
            hr2Color = Color.black
            
            oxi1Color = Color.black
            oxi2Color = Color.black
            
            bp1Color = Color.black
            bp2Color = Color.black
            
            if (currentAlarm == true) && (previousAlarm == false){
                alarming = true
            }else{
                alarming = false
            }
            
            
            
            let dataString = [String(hr1),String(hr2),String(oxi1),String(oxi2),String(bps1),String(bps2),String(bpd1),String(bpd2),String(alarming),String(self.i)]
            let messageText = dataString.joined(separator:"-")
            
            self.model.session.sendMessage(["message" : messageText], replyHandler: nil) { (error) in
                print(error.localizedDescription)}
            
            //print(messageText + "from watch")
            
            print(NSDate().timeIntervalSince1970)
            
            
            previousAlarm = currentAlarm
            currentAlarm = false
            
            
            
            //print(self.vitalData)
            self.i += 1;
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
