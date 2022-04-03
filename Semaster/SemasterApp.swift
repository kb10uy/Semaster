import SwiftUI

@main
struct SemasterApp: App {
    private let persistenceController = PersistenceController.shared
    private let watchController = WatchController.shared
    
    var body: some Scene {
        WindowGroup {
            CheckinsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
