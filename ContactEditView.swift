//
//  ContactDetailView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct ContactEditView: View {
    @StateObject var contact:Contact
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            TextField("Name", text: $contact.editName)
            TextField("Number", text: $contact.editNumber)
        }.navigationBarItems(trailing:Button("Save"){
            //save the contact
            contact.name = contact.editName
            contact.number = contact.editNumber
            dismiss()
        })
        //If the user hides the view before saving, then we cancel changes
        .onDisappear(perform:{
            contact.editName = contact.name
            contact.editNumber = contact.number
        })
    }
}

#Preview {
    ContactDetailView(contact:Contact(name:"Example", number:"012345"))
}
