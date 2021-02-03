//
//  Header.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2021-02-03.
//

import SwiftUI

struct HeaderView: View {
    var definition: Definition
    
    var body: some View {
        Text(definition.meta.id)
        HStack {
            Text(definition.hwi.hw)
            Text(definition.fl)
            Text(definition.meta.offensive ? "offensive" : "")
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let meta = Meta(id: "coffee", offensive: false)
        let hwi = Hwi(hw: "hwi")
        let definition = Definition(meta: meta, hwi: hwi, fl: "noun", shortdef: ["it's great", "it's really great"])
        
        HeaderView(definition: definition)
    }
}
