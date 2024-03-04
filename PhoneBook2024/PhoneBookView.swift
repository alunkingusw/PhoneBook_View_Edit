//
//  PhoneBookView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct PhoneBookView: View {
    @State var showView = false
    @State var searchText = ""
    @ObservedObject var data:Contacts
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationView{
            List(data.contacts.filter(
                {"\($0.name)".localizedCaseInsensitiveContains(searchText) || searchText.isEmpty})){ contact in
                    NavigationLink(destination: ContactDetailView(contact: contact)) {
                        ContactRowView(contact: contact)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        NavigationLink(destination: ContactEditView(contact: contact)) {
                            Text("Edit")
                        }
                        .tint(.yellow)
                    }
                    /*NavigationLink{
                        ContactDetailView(contact: contact)
                    } label:{
                        ContactRowView(contact:contact)
                    }
                    .swipeActions(edge:HorizontalEdge.trailing, allowsFullSwipe:false, content:{NavigationLink("Edit") {
                        ContactEditView(contact: contact)
                    }.tint(.yellow)})*/
                    }.navigationTitle("Contacts")
                .toolbar{
                    ToolbarItemGroup(placement: .primaryAction){
                        Button("Add", systemImage: "person.fill.badge.plus") {
                            showView.toggle()
                        }.sheet(isPresented:$showView){
                            ContactAddView(contactList:data)
                        }
                        
                        Menu{
                            Picker(selection:$data.sortBy, label:
                                    Text("Sorting Options")){
                                    Text("A-Z").tag(0)
                                    Text("Z-A").tag(1)
                            }
                        }
                    label:{
                        Label("Sort", systemImage:"arrow.up.arrow.down")
                    }
                    }
                    
                }
        }.searchable(text:$searchText)
        .onChange(of: scenePhase){ phase in
            if phase == .inactive { saveAction()}
        }
    }
}

#Preview {
    PhoneBookView(data:Contacts(),saveAction:{})
}
