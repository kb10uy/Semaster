import Foundation
import CoreData

func constructPreviewCheckin(context: NSManagedObjectContext, quality: Double, amount: Double) -> Checkin {
    let checkin = Checkin(context: context)
    checkin.id = UUID()
    checkin.quality = quality
    checkin.amount = amount
    checkin.comment = "Test"
    checkin.createdAt = Date()
    return checkin
}
