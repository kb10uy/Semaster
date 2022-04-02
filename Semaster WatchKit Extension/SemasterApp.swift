//
//  SemasterApp.swift
//  Semaster WatchKit Extension
//
//  Created by Yū Kobayashi on 2022/03/26.
//

import SwiftUI

@main
struct SemasterApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
