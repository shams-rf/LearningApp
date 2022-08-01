//
//  LearningApp.swift
//  Shared
//
//  Created by Shamsuddin Refaei on 01/08/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
