import SwiftUI

struct HomeView: View {
    @AppStorage("CheckinsCount")
    private var checkinsCount = 0
    
    @AppStorage("LastCheckinDate")
    private var lastCheckinDate: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Caption.Checkins")
                            .font(.caption)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(checkinsCount)")
                            .font(.title2)
                    }
                }
                VStack {
                    HStack {
                        Text("Caption.LastCheckin")
                            .font(.caption)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(lastCheckinDate)
                            .font(.title3)
                    }
                }

                Spacer()
                
                NavigationLink(destination: EditCheckinView()) {
                    Text("Action.Checkin")
                }
            }
            .navigationTitle("Title.Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
