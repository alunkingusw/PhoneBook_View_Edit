//
//  ContactAddView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

struct ContactAddView: View {
    @ObservedObject var contactList:Contacts
    //boolean to control the presence of the image picker
    @State private var showImagePicker = false
    @State var image:Image?
    @State private var inputImage: UIImage?
    @StateObject var newContact = Contact(name:"", number:"")
    @Environment(\.dismiss) private var dismiss
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        //store the image as a view for this screen
        image = Image(uiImage:inputImage)
        //save the image data to the contact
        newContact.image = inputImage
    }
    
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
                    //trigger a sort here to keep things in order.
                    dismiss()
                }){
                    Text("Save")
                }
            }.padding()
            VStack(alignment: .leading){
                ZStack{
                    Rectangle().fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?.resizable().scaledToFit()
                }.onTapGesture {
                    showImagePicker = true
                }
                Text("Name")
                TextField("Enter name", text:$newContact.name)
                TextField("Number", text:$newContact.number)
            }.padding()
            Spacer()
                .onChange(of: inputImage){_ in loadImage()}
                .sheet(isPresented: $showImagePicker){
                    ImagePicker(image: $inputImage)
                }
        }
    }
}

#Preview {
    ContactAddView(contactList:Contacts())
}
