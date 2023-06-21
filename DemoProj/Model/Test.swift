//
//  Test.swift
//  DemoProj
//
//  Created by Кирилл Сутормин on 20.06.2023.
//

import Foundation
import SwiftData
import Observation

@Model
final class Test: Decodable, Identifiable {
    var id: Int = 0
    
//    @Attribute(.unique)
    var index: Int
    
    @Transient
    var tests: [TestElement] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        index = try container.decode(Int.self, forKey: .index)
        tests = try container.decode([TestElement].self, forKey: .tests)
    }
}

extension Test {
    final class TestElement: Decodable {
        let correctAnswer: String
        let firstAnswer: String
        let secondAnswer: String
        let thirdAnswer: String
        let question: String
        
        enum CodingKeys: CodingKey {
            case correctAnswer, firstAnswer, secondAnswer, thirdAnswer, question
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            correctAnswer = try container.decode(String.self, forKey: .correctAnswer)
            firstAnswer = try container.decode(String.self, forKey: .firstAnswer)
            secondAnswer = try container.decode(String.self, forKey: .secondAnswer)
            thirdAnswer = try container.decode(String.self, forKey: .thirdAnswer)
            question = try container.decode(String.self, forKey: .question)
        }
    }
    
    fileprivate enum CodingKeys: CodingKey {
        case id, index, tests
    }
}
