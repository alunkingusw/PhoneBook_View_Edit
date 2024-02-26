//
//  PhoneBookView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct PhoneBookView: View {
    @State var showView = false
    @ObservedObject var data:Contacts
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationStack{
            List(data.contacts){ contact in
                NavigationLink{
                    ContactDetailView(contact: contact)
                } label:{ContactRowView(contact:contact).swipeActions(edge:HorizontalEdge.trailing, allowsFullSwipe:false, content:{NavigationLink("Edit") {
                    ContactEditView(contact: contact)
                }.tint(.yellow)})}
            }.navigationTitle("Contacts")
                .toolbar{
                    Button("Add", systemImage: "person.fill.badge.plus") {
                        showView.toggle()
                    }.sheet(isPresented:$showView){
                        ContactAddView(contactList:data)
                    }
                }
        }
        .onChange(of: scenePhase){ phase in
            if phase == .inactive { saveAction()}
        }
    }
}

#Preview {
    PhoneBookView(data:Contacts(),saveAction:{})
}
