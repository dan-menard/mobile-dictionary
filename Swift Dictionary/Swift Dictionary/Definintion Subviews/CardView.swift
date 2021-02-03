//
//  CardView.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2021-02-03.
//

import SwiftUI

struct CardView: View {
    var definition: Definition
    
    var body: some View {
        VStack {
            HeaderView(definition: definition)
            VStack {
                ForEach(definition.shortdef, id:\.self) { def in
                    Text(def)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let meta = Meta(id: "coffee", offensive: false)
        let hwi = Hwi(hw: "hwi")
        let definition = Definition(meta: meta, hwi: hwi, fl: "noun", shortdef: ["it's great", "it's really great"])
        
        CardView(definition: definition)
    }
}
