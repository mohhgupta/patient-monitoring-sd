//
//  ContentView.swift
//  ResurrectionSD
//
//  Created by Mohh Gupta on 4/5/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @EnvironmentObject var model : ViewModelPhone
   // @Environment(\.exportFiles) var exportAction
    @State var reachable = "No"
    //@State var difference = 0.0
    @State var showingExporter = false
    @State var url = ""
    @State var dataOutput = [[String]]()
    @State var dataOutputString = ""
    //let messageText  = "hi"
    //@State var dataArray = []
    //@State var hr1 = model.dataArray[0]
    
    // MARK: Functions
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func saveData(buttonPressed: String, patientNumber: Int){
        let pressedTime = NSDate().timeIntervalSince1970
        let difference = self.model.recievedTime - pressedTime
        dataOutput.append([self.model.iterationNumber,String(patientNumber),buttonPressed,String(difference)])
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                HStack(spacing: 0) {
                    Text("Patient 1")
                        .frame(width: geometry.size.width*0.4)
                        .font(.system(size:25))
                    VStack(spacing: 0){
                        Button(action: {
                            dataOutputString = json(from: dataOutput)!
                            showingExporter.toggle()
                        }) {
                            Text("Export Data")
                        }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height:35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    Text("Reachable \(reachable)")
                        .frame(width: geometry.size.width*0.2)
                            .font(.system(size:10))
                    }
                    Text("Patient 2")
                        .frame(width: geometry.size.width*0.4)
                        .font(.system(size:25))
                }
                
                Spacer()
                //MARK: Heart Rate
                HStack(spacing:0){
                    Text(self.model.dataArray[0])
                        .frame(width: geometry.size.width*0.5, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(self.model.dataArray[1])
                        .frame(width: geometry.size.width*0.5, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                }
                
                
                HStack(spacing: 0) {
                    
                   
                    VStack {
                        
                        Button(action: {
                            saveData(buttonPressed: "Heart Rate Low", patientNumber: 1)
                            print(dataOutput)
                        }) {
                            Text("Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                        
                        /*Button(action: {
                            saveData(buttonPressed: "Heart Rate Mid High", patientNumber: 1)
                            print(dataOutput)
                        }) {
                            Text("Mid High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                    }
                    
                    VStack {
                        
                        /*Button(action: {
                            saveData(buttonPressed: "Heart Rate Mid Low", patientNumber: 1)
                            print(dataOutput)
                        }) {
                            Text("Mid Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                        Button(action: {
                            saveData(buttonPressed: "Heart Rate High", patientNumber: 1)
                            print(dataOutput)
                        }) {
                            Text("High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                    }
                    
                    Image(systemName: "heart.fill")
                        .padding()
                        .scaledToFit()
                    
                    VStack {
                        
                        Button(action: {
                            saveData(buttonPressed: "Heart Rate Low", patientNumber: 2)
                            print(dataOutput)
                        }) {
                            Text("Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                        /*Button(action: {
                            saveData(buttonPressed: "Heart Rate Mid High", patientNumber: 2)
                        }) {
                            Text("Mid High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                    }
                    
                    VStack {
                        
                        /*Button(action: {
                            saveData(buttonPressed: "Heart Rate Mid Low", patientNumber: 2)
                        }) {
                            Text("Mid Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                        Button(action: {
                            saveData(buttonPressed: "Heart Rate High", patientNumber: 2)
                        }) {
                            Text("High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                    }
                    
                        
                }
                
                Spacer()
                
                HStack(spacing:0){
                    Text(self.model.dataArray[2])
                        .frame(width: geometry.size.width*0.5, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(self.model.dataArray[3])
                        .frame(width: geometry.size.width*0.5, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                }
                //MARK: O2
                
                HStack(spacing: 0) {
                   
                    VStack {
                        
                        Button(action: {
                            saveData(buttonPressed: "Oxi Low", patientNumber: 1)
                        }) {
                            Text("Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                        /*Button(action: {
                            saveData(buttonPressed: "Oxi Mid High", patientNumber: 1)
                        }) {
                            Text("Mid High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                    }
                    
                    VStack {
                        
                       /* Button(action: {
                            saveData(buttonPressed: "Oxi Mid Low", patientNumber: 1)
                        }) {
                            Text("Mid Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                        Button(action: {
                            saveData(buttonPressed: "Oxi High", patientNumber: 1)
                        }) {
                            Text("High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                    }
                    
                    Image(systemName: "lungs.fill")
                        .padding()
                        .scaledToFit()
                    
                    VStack {
                        
                        Button(action: {
                            saveData(buttonPressed: "Oxi Low", patientNumber: 2)
                        }) {
                            Text("Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                       /* Button(action: {
                            saveData(buttonPressed: "Oxi Mid High", patientNumber: 2)
                        }) {
                            Text("Mid High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                    }
                    
                    VStack {
                        
                        /*Button(action: {
                            saveData(buttonPressed: "Oxi Mid Low", patientNumber: 2)
                        }) {
                            Text("Mid Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                        Button(action: {
                            saveData(buttonPressed: "Oxi High", patientNumber: 2)
                        }) {
                            Text("High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                    }
                    
                    
                        
                }
                
                Spacer()
                // MARK: Blood Pressure
                
                HStack(spacing:0){
                    Text(self.model.dataArray[4] + "/" + self.model.dataArray[6])
                        .frame(width: geometry.size.width*0.5, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(self.model.dataArray[5] + "/" + self.model.dataArray[7])
                        .frame(width: geometry.size.width*0.5, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                }
                
                HStack(spacing: 0) {
                   
                    VStack {
                        
                        Button(action: {
                            saveData(buttonPressed: "BP Low", patientNumber: 1)
                        }) {
                            Text("Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                        /*Button(action: {
                            saveData(buttonPressed: "BP Mid High", patientNumber: 1)
                        }) {
                            Text("Mid High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                    }
                    
                    VStack {
                        
                        /*Button(action: {
                            saveData(buttonPressed: "BP Mid Low", patientNumber: 1)
                        }) {
                            Text("Mid Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                        Button(action: {
                            saveData(buttonPressed: "BP High", patientNumber: 1)
                        }) {
                            Text("High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                    }
                    
                    Image(systemName: "barometer")
                        .padding()
                        .scaledToFit()
                    
                    VStack {
                        
                        Button(action: {
                            saveData(buttonPressed: "BP Low", patientNumber: 2)
                        }) {
                            Text("Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                       /* Button(action: {
                            saveData(buttonPressed: "BP Mid High", patientNumber: 2)
                        }) {
                            Text("Mid High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                    }
                    
                    VStack {
                        
                        /*Button(action: {
                            saveData(buttonPressed: "BP Mid Low", patientNumber: 2)
                        }) {
                            Text("Mid Low")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .font(.system(size:12))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)*/
                        
                        Button(action: {
                            saveData(buttonPressed: "BP High", patientNumber: 2)
                        }) {
                            Text("High")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size:15))
                        }.frame(width: geometry.size.width * 0.35*0.5, height: geometry.size.height*0.25*0.5)
                        
                        
                    }
                    
                    
                        
                }
                
            }
            
        }.fileExporter(isPresented: $showingExporter, document: Doc(initialText: dataOutputString), contentType: .plainText) { result in
            switch result {
                case .success(let url):
                    print("Saved to \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        .onAppear{
            //hr1 = self.model.dataArray[0] as! String
            //self.dataArray = self.model.messageText.components(separatedBy: "-")
        }
    }
    
        /*VStack{
                    Text("Reachable \(reachable)")
                    
                    Button(action: {
                        if self.model.session.isReachable{
                            self.reachable = "Yes"
                        }
                        else{
                            self.reachable = "No"
                        }
                        
                        print("button")
                        
                    }) {
                        Text("Update")
                    }
            Text(self.model.messageText)
                }*/
            /*Button(action: {
                       self.model.session.sendMessage(["message" : self.messageText], replyHandler: nil) { (error) in
                           print(error.localizedDescription)
                       }
                   }) {
                   Text("Send Message")
                   }*/
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModelPhone())
    }
}

struct Doc: FileDocument {
    static var readableContentTypes = [UTType.plainText]
    
    // by default our document is empty
       //var text = ""
        var text : String

       // a simple initializer that creates new, empty documents
        init(initialText: String = "") {
            text = initialText
        }

       // this initializer loads data that has been saved previously
       init(configuration: ReadConfiguration) throws {
           //url = ""
            text = "weeeo"
       }

       // this will be called when the system wants to write our data to disk
        func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
            let data = Data(text.utf8)
            return FileWrapper(regularFileWithContents: data)
        }
}
