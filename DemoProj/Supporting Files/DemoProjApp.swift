//
//  DemoProjApp.swift
//  DemoProj
//
//  Created by Кирилл Сутормин on 20.06.2023.
//

import SwiftUI
import SwiftData

@main
struct DemoProjApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Test.self)
        }
    }
}
