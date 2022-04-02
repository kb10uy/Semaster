import SwiftUI

struct DetailsView: View {
    @Environment(\.managedObjectContext)
    private var context
    
    let checkin: Checkin

    var body: some View {
        List {
            Section(header: Text("Caption.Summary")) {
                HStack {
                    VStack {
                        Text("\(checkin.quality, specifier: "%.1f")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Caption.Quality")
                    }
                    .foregroundColor(Color("CheckinQuality"))
                    .frame(maxWidth: .infinity)

                    VStack {
                        Text("\(checkin.amount, specifier: "%.1f")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Caption.Amount")
                    }
                    .foregroundColor(Color("CheckinAmount"))
                    .frame(maxWidth: .infinity)
                }
                HStack {
                    Spacer()
                    Text("\(checkin.createdAt!, formatter: FullDateFormatter)")
                        .font(.title3)
                    Spacer()
                }
            }
            
            Section(header: Text("Caption.Comment")) {
                Text(checkin.comment ?? "")
            }
        }
        .navigationTitle("Title.Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let checkin = constructPreviewCheckin(context: viewContext, quality: 3.0, amount: 3.0)
        
        return DetailsView(checkin: checkin)
            .environment(\.managedObjectContext, viewContext)
    }
}
