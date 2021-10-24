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
            RootView(rankingView: RankingView(viewModel: RankingViewModel()),
                     searchView: SearchView(viewModel: SearchViewModel()))
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
