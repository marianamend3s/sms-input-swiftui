//
//  Coordinator.swift
//  sms-input-swiftui
//
//  Created by Mariana Mendes on 7/21/21.
//

import SwiftUI

class Coordinator: NSObject, UITextViewDelegate {
    @Binding var text: String
    @Binding var viewHeight: CGFloat
    var maxViewLine: CGFloat?

    init(text: Binding<String>, viewHeight: Binding<CGFloat>, maxViewLine: CGFloat? = nil, onEditChange: (() -> Void)? = nil, onDone: (() -> Void)? = nil) {
        self._text = text
        self._viewHeight = viewHeight
        self.maxViewLine = maxViewLine
    }

    func textViewDidChange(_ textView: UITextView) {
        self.text = textView.text
        let predictedSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))

        let lines = TextViewWrapper.lineCalculator(textView)

        if viewHeight != predictedSize.height && lines <= maxViewLine! {
            viewHeight = predictedSize.height
        } else if lines > maxViewLine! {

            self.viewHeight = self.maxViewLine! * textView.font!.lineHeight
        }
    }
}
