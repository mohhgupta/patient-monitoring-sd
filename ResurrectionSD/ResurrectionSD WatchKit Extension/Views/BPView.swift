//
//  BPView.swift
//  ResurrectionSD WatchKit Extension
//
//  Created by Mohh Gupta on 4/5/21.
//

import SwiftUI

struct BPView: View {
    var sys : Int
    var dia : Int
    var arrowDirection: String
    var body: some View {
        GeometryReader{ geo in
        HStack {
            VStack {
                Text("\(sys)")
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                Text("\(dia)")
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
            }
            .frame(width: geo.size.width/2, height: geo.size.height, alignment: .center)
           Image(systemName: arrowDirection)
            .frame(width: geo.size.width/2, height: geo.size.height, alignment: .center)
        }
    }
    }
}

struct BPView_Previews: PreviewProvider {
    static var previews: some View {
        BPView(sys: 180, dia: 68, arrowDirection: "arrow.up.right")
    }
}
