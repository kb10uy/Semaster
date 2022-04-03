import SwiftUI

struct EditCheckinView: View {
    @Environment(\.dismiss)
    private var dismiss
    
    @State private var qualityValue: Double = 2.5
    @State private var amountValue: Double = 2.5
    @State private var selectedComment: String = ""
    
    @State private var showingFailure: Bool = false
    @State private var commitError: CheckinError? = nil
    
    var body: some View {
        NavigationView {
            VStack {
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
                    
                    VStack {
                        Picker("Comment", selection: $selectedComment) {
                            Text("Caption.NoComment").tag("")
                        }
                        
                        Button(action: addCheckin) {
                           Text("Action.Commit")
                        }
                        .alert(
                            isPresented: $showingFailure,
                            error: commitError,
                            actions: { error in
                            },
                            message: { error in
                                Text(error.failureReason ?? "Unknown error")
                            }
                        )
                    }
                }
                .tabViewStyle(.page)
            }
            .navigationTitle("Title.Checkin")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addCheckin() {
        do {
            try WatchController.shared.sendCheckinMessage(
                quality: qualityValue,
                amount: amountValue,
                comment: selectedComment
            )
            dismiss()
        } catch {
            commitError = error as? CheckinError
            showingFailure = true
        }
    }
}

struct QualityEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditCheckinView()
    }
}
