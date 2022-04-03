import SwiftUI

@main
struct SemasterApp: App {
    let persistenceController = PersistenceController.shared
    let watchController = WatchController.shared
    
    var body: some Scene {
        WindowGroup {
            CheckinsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
