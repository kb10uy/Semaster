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
