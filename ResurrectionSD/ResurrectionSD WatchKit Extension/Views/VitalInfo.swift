//
//  VitalInfo.swift
//  ResurrectionSD WatchKit Extension
//
//  Created by Mohh Gupta on 4/5/21.
//

import SwiftUI

struct VitalInfo: View {
    var vital : Int
    var type : String
    var arrowDirection: String
    var body: some View {
        GeometryReader { geo in
        if type == "hr"{
            HStack {
                Text("\(vital)")
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                    .frame(width: geo.size.width/2, height: geo.size.height, alignment: .center)
                Image(systemName: arrowDirection)
                    .frame(width: geo.size.width/2, height: geo.size.height, alignment: .center)
            }
        }
        
        if type == "oxi"{
                HStack {
                    Text("\(vital)" + "%")
                        .font(.caption2)
                        .frame(width: geo.size.width/2, height: geo.size.height, alignment: .center)
                    Image(systemName: arrowDirection)
                        .frame(width: geo.size.width/2, height: geo.size.height, alignment: .center)
                }
            }
        }
    }

}
struct VitalInfo_Previews: PreviewProvider {
    static var previews: some View {
        VitalInfo(vital: 87, type: "hr", arrowDirection: "arrow.up.right")
    }
}
