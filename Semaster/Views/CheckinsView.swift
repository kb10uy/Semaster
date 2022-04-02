import SwiftUI
import CoreData

struct CheckinsView: View {
    @Environment(\.managedObjectContext)
    private var context
    
    @FetchRequest(
        entity: Checkin.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Checkin.createdAt, ascending: false)],
        animation: .default
    )
    private var checkins: FetchedResults<Checkin>
    
    @State private var showingModal: Bool = false
    @State private var showingFailure: Bool = false
    @State private var deletionError: SemasterError? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(checkins) { checkin in
                    NavigationLink(destination: DetailsView(checkin: checkin)) {
                        CheckinRow(checkin: checkin)
                    }
                }
                .onDelete(perform: deleteCheckins)
            }
            .navigationTitle("Title.Checkins")
            .listStyle(PlainListStyle())
            
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        self.showingModal.toggle()
                    }) {
                        Label("Action.Add", systemImage: "drop")
                    }.sheet(isPresented: $showingModal) {
                        AddCheckinModal()
                            .environment(\.managedObjectContext, context)
                    }
                }
            }
        }
    }
    
    private func deleteCheckins(checkinIndices: IndexSet) {
        do {
            for index in checkinIndices {
                context.delete(checkins[index])
            }
            try context.save()
        } catch {
            let nsError = error as NSError
            deletionError = SemasterError(
                nsError: nsError,
                title: NSLocalizedString("Error.FailedToAdd", comment: "Failure"),
                recovery: NSLocalizedString("Action.OK", comment: "OK")
            )
            showingFailure = true
        }
        
    }
}

struct AddCheckinModal: View {
    @Environment(\.managedObjectContext)
    private var context
    
    @Environment(\.dismiss)
    private var dismiss
    
    @State private var qualityValue: Double = 2.5
    @State private var amountValue: Double = 2.5
    @State private var commentValue: String = ""
    
    @State private var showingFailure: Bool = false
    @State private var additionError: SemasterError? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Caption.Quality")
                            .font(.title2)
                        Spacer()
                        Text("\(qualityValue, specifier: "%.1f")")
                            .font(.title2)
                            .bold()
                    }
                    .foregroundColor(Color("CheckinQuality"))
                    Slider(value: $qualityValue, in: 0...5, step: 0.5)
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("Caption.Amount")
                            .font(.title2)
                        Spacer()
                        Text("\(amountValue, specifier: "%.1f")")
                            .font(.title2)
                            .bold()
                    }
                    .foregroundColor(Color("CheckinAmount"))
                    Slider(value: $amountValue, in: 0...5, step: 0.5)
                }
                .padding()
                
                TextField("Caption.Comment", text: $commentValue)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Title.AddCheckin")
            
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addCheckin) {
                        Label("Action.Add", systemImage: "drop")
                            .labelStyle(.titleAndIcon)
                    }
                    .alert(
                        isPresented: $showingFailure,
                        error: additionError,
                        actions: { error in
                            
                        },
                        message: { error in
                            Text(error.failureReason ?? "Unknown error")
                        }
                    )
                }
            }
        }
    }
    
    private func addCheckin() {
        do {
            try insertCheckin(
                viewContext: context,
                quality: qualityValue,
                amount: amountValue,
                comment: commentValue
            )
            reset()
            dismiss()
        } catch {
            let nsError = error as NSError
            additionError = SemasterError(
                nsError: nsError,
                title: NSLocalizedString("Error.FailedToAdd", comment: "Failure"),
                recovery: NSLocalizedString("Action.OK", comment: "OK")
            )
            showingFailure = true
        }
    }
    
    private func reset() {
        qualityValue = 2.5
        amountValue = 2.5
        commentValue = ""
        showingFailure = false
        additionError = nil
    }
}

struct CheckinsView_Previews: PreviewProvider {    
    static var previews: some View {
        Group {
            CheckinsView()
                .environment(
                    \.managedObjectContext,
                     PersistenceController.preview.container.viewContext
                )
            AddCheckinModal()
                .environment(
                    \.managedObjectContext,
                     PersistenceController.preview.container.viewContext
                )
        }
    }
}
