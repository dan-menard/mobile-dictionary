//
//  SearchView.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2021-02-01.
//

import SwiftUI

struct SearchView: View {
    @State private var word: String = ""
    @State private var loadResults: Int? = 0
    @State private var wordData: Data = Data.init()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a word", text: $word)
                NavigationLink(
                    destination: DefinitionView(word: word, data: wordData),
                    tag: 1,
                    selection: $loadResults
                ) {
                    Text("Search").onTapGesture {
                        self.fetchResults(word: word);
                    }
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    func fetchResults(word: String) {
        let url = URL(string: "http://127.0.0.1:3001/?word=\(word)")!
        let req = URLRequest(url: url)
        
        let session = URLSession.shared;
        let task = session.dataTask(with: req) {
            (data, response, error) in
                if let error = error {
                    // TODO
                } else if let data = data {
                    wordData = data;
                    loadResults = 1;
                } else {
                    // Something weird happened
                }
        }
        
        task.resume()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
        }
    }
}
