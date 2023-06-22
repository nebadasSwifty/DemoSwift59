//
//  ContentView.swift
//  DemoProj
//
//  Created by Кирилл Сутормин on 20.06.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(sort: \.index, animation: .bouncy)
    private var tests: [Test]
    
    @State private var isUpdate: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(tests) { test in
                    Section("Тест \(test.index + 1)") {
                        VStack {
                            ForEach(0..<test.tests.count, id: \.self) { index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.secondary)
                                    DisclosureGroup("Вопрос \(index + 1)") {
                                        VStack {
                                            NavigationLink {
                                                AnswersView(viewModel: AnswerViewModel(testElement: test.tests[index]))
                                            } label: {
                                                Text(test.tests[index].question)
                                                    .padding()
                                                    .background {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .fill(.white)
                                                    }
                                                    .foregroundColor(.black)
                                            }
                                        }
                                    }
                                    .accentColor(.white)
                                    .padding()
                                }
                                .padding()
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                        .blur(radius: phase.isIdentity ? 0 : 10)
                                }
                            }
                        }
                    }
                }
                .task {
                    fetchTest()
                }
            }
            .navigationTitle("Вопросы DMV")
        }
    }
    
    private func fetchTest() {
        DispatchQueue.main.async {
            if let url = Bundle.main.url(forResource: "CaliforniaTest", withExtension: "json") {
                do {
                    tests.forEach({
                        modelContext.delete($0)
                    })
                    
                    let data = try Data(contentsOf: url)
                    let _ = try DecoderEncoder
                        .decode(data, by: [Test].self)
                        .forEach({
                            modelContext.insert($0)
                        })
                    
                    if modelContext.hasChanges {
                        try modelContext.save()
                    }
                } catch {
                    print(String(describing: error))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
