import SwiftUI

@main
struct SemasterApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            CheckinsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
