//
//  ContactRowView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct ContactRowView: View {
    @StateObject var contact:Contact
    
    var body: some View {
        HStack{
            Text(contact.name.prefix(1))
                .font(.title2)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(0.0)
                .frame(width: 40.0, height: 40.0)
                .background(Color.blue)
                .clipShape(Circle())
            VStack(alignment: .leading){
                Text(contact.name)
            }.padding(.leading, 15.0)
            Spacer()
                
        }
    }
}

#Preview {
    ContactRowView(contact:Contact(name:"Example", number:"012345"))
}
