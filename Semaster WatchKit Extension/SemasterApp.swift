import SwiftUI

@main
struct SemasterApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            HomeView()
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
