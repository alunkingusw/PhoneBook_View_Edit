//
//  ContactAddView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct ContactAddView: View {
    @ObservedObject var contactList:Contacts
    @StateObject var newContact = Contact(name:"", number:"")
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    dismiss()
                }){
                    Text("Cancel")
                }
                Spacer()
                Button(action:{
                    contactList.contacts.append(newContact)
                    dismiss()
                }){
                    Text("Save")
                }
            }.padding()
            VStack(alignment: .leading){
                Text("Name")
                TextField("Enter name", text:$newContact.name)
                TextField("Number", text:$newContact.number)
            }.padding()
            Spacer()
        }
    }
}

#Preview {
    ContactAddView(contactList:Contacts())
}
