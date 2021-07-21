//
//  TextViewWrapper.swift
//  sms-input-swiftui
//
//  Created by Mariana Mendes on 7/21/21.
//

import SwiftUI

struct TextViewWrapper: UIViewRepresentable {

    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var viewHeight: CGFloat
    var maxViewLine: CGFloat?

    init(text: Binding<String>, viewHeight: Binding<CGFloat>, maxViewLine: CGFloat? = nil) {
        self._text = text
        self._viewHeight = viewHeight

        guard maxViewLine != nil else {
            self.maxViewLine = 3
            return
        }
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 5
        textView.textColor = .black
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = context.coordinator

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            if uiView.text != self.text { uiView.text = self.text }

            let predictedSize = uiView.sizeThatFits(CGSize(width: uiView.frame.width, height: CGFloat.greatestFiniteMagnitude))

            let lines = Self.lineCalculator(uiView)

            if viewHeight != predictedSize.height && lines <= maxViewLine! {
                viewHeight = predictedSize.height
            } else if lines > maxViewLine! {
                self.viewHeight = self.maxViewLine! * uiView.font!.lineHeight
            }
        }
    }

    static func lineCalculator(_ textView: UITextView) -> CGFloat {
        let precalculatedLines = (textView.contentSize.height - 16) / textView.font!.lineHeight
        return precalculatedLines.rounded(.down)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, viewHeight: $viewHeight, maxViewLine: maxViewLine)
    }
}
