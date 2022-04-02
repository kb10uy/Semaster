import SwiftUI

struct CheckinRow: View {
    @Environment(\.managedObjectContext)
    private var context
    
    let checkin: Checkin
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(String(checkin.quality))
                        .bold()
                        .font(.title)
                        .foregroundColor(Color("CheckinQuality"))
                    Text(String(checkin.amount))
                        .bold()
                        .font(.title)
                        .foregroundColor(Color("CheckinAmount"))
                }
                
            }
            Spacer()
            VStack {
                Text("\(checkin.createdAt!, formatter: FullDateFormatter)")
                    .font(.caption)
            }
        }
    }
}

struct CheckinRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let checkin = constructPreviewCheckin(context: viewContext, quality: 3.0, amount: 3.0)

        return Group {
            CheckinRow(checkin: checkin)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, viewContext)
            CheckinRow(checkin: checkin)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
