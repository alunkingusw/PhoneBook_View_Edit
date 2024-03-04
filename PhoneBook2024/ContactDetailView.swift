//
//  ContactDetailView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct ContactDetailView: View {
    @StateObject var contact:Contact
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Name: \(contact.name)")
            Text("Number: \(contact.number)")
            if let image = contact.image{
                Image(uiImage:image).resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 100)
            }
            
        }.navigationBarItems(trailing:NavigationLink("Edit"){ContactEditView(contact: contact)})
    }
}

#Preview {
    ContactDetailView(contact:Contact(name:"Example", number:"012345"))
}
