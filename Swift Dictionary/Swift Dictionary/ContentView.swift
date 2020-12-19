//
//  ContentView.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2020-12-19.
//

import SwiftUI

struct SearchView: View {
    @State private var word: String = "";
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a word", text: $word)
                NavigationLink(destination: DefinitionView(word: word)) {
                    Text("Search")
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct DefinitionView: View {
    let word: String;
    
    var body: some View {
        VStack {
            Text("Definition page for \(word)")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
        }
    }
}
