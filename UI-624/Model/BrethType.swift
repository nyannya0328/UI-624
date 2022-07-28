//
//  BrethType.swift
//  UI-624
//
//  Created by nyannyan0328 on 2022/07/28.
//

import SwiftUI

struct BreathType: Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var color : Color
  
}
let sampleTypes : [BreathType] = [

    .init(title: "Anger", color: .mint),
    .init(title: "Irritation", color: .brown),
    .init(title: "Sadness", color: Color("Purple")),
]


