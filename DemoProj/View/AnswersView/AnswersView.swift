//
//  AnswersView.swift
//  DemoProj
//
//  Created by Кирилл Сутормин on 21.06.2023.
//

import SwiftUI

struct AnswersView: View {
    @State var viewModel: AnswerViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Вопрос:\n\(viewModel.question)")
                    .font(.system(.title3, design: .rounded, weight: .black))
                
                Spacer()
                
                Text("1: \(viewModel.firstAnswer)")
                    .font(.system(.title3, design: .rounded, weight: .black))
                    .padding(.top)
                Text("2: \(viewModel.secondAnswer)")
                    .font(.system(.title3, design: .rounded, weight: .black))
                    .padding(.top)
                Text("3: \(viewModel.thirdAnswer)")
                    .font(.system(.title3, design: .rounded, weight: .black))
                    .padding(.top)
                
                Spacer()
                
                Text("Верный ответ:\n\(viewModel.correctAnswer)")
                    .font(.system(.title3, design: .rounded, weight: .black))
                    .padding(.top)
                    .foregroundColor(.green)
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .task {
                viewModel.parseElement()
            }
        }
    }
}
