//
//  DefinitionView.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2021-02-01.
//

import SwiftUI

struct DefinitionView: View {
    let word: String
    let data: Data
    
    var body: some View {
        VStack {
            Text("Definition page for \(word)")
            Text("Also \(data.description)")
        }
    }
}
