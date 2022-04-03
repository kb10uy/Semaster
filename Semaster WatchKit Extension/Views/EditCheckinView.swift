import SwiftUI

struct EditCheckinView: View {
    @State var qualityValue: Double = 2.5
    @State var amountValue: Double = 2.5
    
    var body: some View {
        NavigationView {
            TabView {
                CheckinProperty(
                    value: $qualityValue,
                    captionKey: "Caption.Quality",
                    color: Color("CheckinQuality")
                )
                
                CheckinProperty(
                    value: $amountValue,
                    captionKey: "Caption.Amount",
                    color: Color("CheckinAmount")
                )

                // Commit
                Button(action: {}) {
                   Text("Action.Commit")
                }
            }
            .tabViewStyle(.page)
            .navigationTitle("Title.Quality")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct QualityEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditCheckinView()
    }
}
