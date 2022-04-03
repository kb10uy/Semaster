import SwiftUI

struct HomeView: View {
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
                        Text("0")
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
                        Text("2022/12/31 23:59")
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
