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
        List(tests) { test in
            Section("Тест \(test.index + 1)") {
                VStack {
                    ForEach(0..<test.tests.count, id: \.self) { index in
                        DisclosureGroup("Вопрос \(index + 1)") {
                            VStack {
                                ZStack {
                                    Text(test.tests[index].question)
                                        .padding()
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.secondary)
                                }
                                .padding()
                            }
                        }
                        .padding()
                    }
                }
//
            }
        }
        .onTapGesture {
            // if tap on list all elements is expanded
            return
        }
        .listStyle(.sidebar)
        .onAppear(perform: {
            fetchTest()
        })
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
