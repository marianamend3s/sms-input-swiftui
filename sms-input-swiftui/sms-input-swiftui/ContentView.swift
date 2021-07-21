//
//  ContentView.swift
//  sms-input-swiftui
//
//  Created by Mariana Mendes on 7/21/21.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var text = ""

    var body: some View {
        VStack {
            Spacer()
            HStack {
                MultiLineText(text: $text)

                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                }
                .disabled(text.isEmpty == true)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
