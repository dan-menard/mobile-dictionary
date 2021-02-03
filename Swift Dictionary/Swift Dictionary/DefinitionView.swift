//
//  DefinitionView.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2021-02-01.
//

import SwiftUI

struct Definition: Decodable {
    let meta: Meta
    let hwi: Hwi
    let fl: String
    let shortdef: [String]
}

struct Meta: Decodable {
    let id: String
    let offensive: Bool
}

struct Hwi: Decodable {
    let hw: String
}

struct DefinitionView: View {
    let word: String
    let data: Data
    
    @State private var decodedData: [Definition] = []
    
    var body: some View {
        VStack {
            Text("Definition page for \(word)")
            
        }.onAppear {
            self.decodeData()
        }
    }
    
    func decodeData() {
        do {
            decodedData = try JSONDecoder().decode([Definition].self, from: data)
            print(decodedData)
        }
        catch {
            print(error)
        }
    }
}

struct DefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DefinitionView(word: "coffee", data: Data.init())
        }
    }
}
