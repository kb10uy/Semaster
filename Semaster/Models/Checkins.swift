import Foundation
import CoreData

func insertCheckin(viewContext: NSManagedObjectContext, quality: Double, amount: Double, comment: String) throws {
    let checkin = Checkin(context: viewContext)
    checkin.id = UUID()
    checkin.createdAt = Date()
    checkin.quality = quality
    checkin.amount = amount
    checkin.comment = comment
    
    try viewContext.save()
}

func updateWatchStatus(viewContext: NSManagedObjectContext) throws {
    let entity = Checkin.entity()
    
    let countRequest = NSFetchRequest<Checkin>(entityName: entity.name!)
    let count = try viewContext.count(for: countRequest)
    
    let lastCheckinRequest = NSFetchRequest<Checkin>(entityName: entity.name!)
    lastCheckinRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Checkin.createdAt, ascending: false)]
    lastCheckinRequest.fetchLimit = 1
    let lastCheckin = try viewContext.fetch(lastCheckinRequest)
    
    let lastDateString: String
    if lastCheckin.isEmpty {
        lastDateString = "Never committed"
    } else {
        lastDateString = FullDateFormatter.string(from: lastCheckin[0].createdAt ?? Date())
    }
    print("\(count): \(lastDateString)")
    
    try WatchController.shared.sendStatus(count: count, lastDate: lastDateString)
}
