//
//  AnswerViewModel.swift
//  DemoProj
//
//  Created by Кирилл Сутормин on 21.06.2023.
//

import Foundation
import Observation

@Observable
final class AnswerViewModel {
    private var testElement: Test.TestElement? = nil
    
    private(set) var question: String = ""
    private(set) var firstAnswer: String = ""
    private(set) var secondAnswer: String = ""
    private(set) var thirdAnswer: String = ""
    private(set) var correctAnswer: String = ""
    
    init(testElement: Test.TestElement?) {
        self.testElement = testElement
    }
    
    func parseElement() {
        if let testElement {
            question = testElement.question
            firstAnswer = testElement.firstAnswer
            secondAnswer = testElement.secondAnswer
            thirdAnswer = testElement.thirdAnswer
            correctAnswer = testElement.correctAnswer
        }
    }
}
