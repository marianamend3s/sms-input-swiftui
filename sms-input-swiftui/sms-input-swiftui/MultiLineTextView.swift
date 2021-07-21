//
//  MultiLineTextView.swift
//  sms-input-swiftui
//
//  Created by Mariana Mendes on 7/21/21.
//

import SwiftUI

struct MultiLineText: View {
    @State private var viewHeight: CGFloat = 38
    @Binding var text: String
    private var maxViewLine: CGFloat?

    init(text: Binding<String>, maxViewLine: CGFloat? = nil) {
        self._text = text
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextViewWrapper(text: self.$text,
                            viewHeight: self.$viewHeight,
                            maxViewLine: self.maxViewLine)
                .frame(maxHeight: self.viewHeight)
        }
    }
}
