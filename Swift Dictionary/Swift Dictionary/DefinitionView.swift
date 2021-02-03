//
//  DefinitionView.swift
//  Swift Dictionary
//
//  Created by Dan Menard on 2021-02-01.
//
//  The horizontal swipe logic was borrowed from this wonderful blog post: https://habr.com/en/post/476494/
//

import SwiftUI

struct Definition: Decodable, Hashable {
    static func == (lhs: Definition, rhs: Definition) -> Bool {
        return lhs.meta.id == rhs.meta.id
    }
    
    let meta: Meta
    let hwi: Hwi
    let fl: String
    let shortdef: [String]
}

struct Meta: Decodable, Hashable {
    let id: String
    let offensive: Bool
}

struct Hwi: Decodable, Hashable {
    let hw: String
}

struct DefinitionView: View {
    let word: String
    let data: Data
    
    @State private var definitions: [Definition] = []
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    var body: some View {
        VStack {
            Text("Definition page for \(word)")
            GeometryReader { geometry in
                return ScrollView(.horizontal, showsIndicators: true)
                {
                    HStack {
                        ForEach(definitions, id: \.self) { definition in
                            CardView(definition: definition)
                                .frame(width: geometry.size.width)
                        }
                    }
                }
                .content.offset(x: self.offset)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                        })
                        .onEnded({ value in
                            if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.definitions.count - 1 {
                                self.index += 1
                            }
                            if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                                self.index -= 1
                            }
                            withAnimation { self.offset = -(geometry.size.width) * CGFloat(self.index) }
                        })
                )
            }
        }.onAppear {
            self.decodeData()
        }
    }
    
    func decodeData() {
        do {
            definitions = try JSONDecoder().decode([Definition].self, from: data)
            print(definitions)
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
