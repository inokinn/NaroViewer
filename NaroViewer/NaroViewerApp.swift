//
//  NaroViewerApp.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/10.
//

import SwiftUI

@main
struct NaroViewerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
