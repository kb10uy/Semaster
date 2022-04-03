import SwiftUI

@main
struct SemasterApp: App {
    @WKExtensionDelegateAdaptor
    private var extensionDelegate: SemasterExtensionDelegate
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            HomeView()
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
