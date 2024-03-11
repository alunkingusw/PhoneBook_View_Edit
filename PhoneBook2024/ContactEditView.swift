//
//  ContactDetailView.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI
import LocalAuthentication





struct ContactEditView: View {
    @StateObject var contact:Contact
    @Environment(\.dismiss) private var dismiss
    @State private var inputImage: UIImage?
    //variable to check if user has authenticated
    @State private var showImagePicker = false
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        contact.editImage = inputImage
    }

    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                Rectangle().fill(.secondary)
                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
                if let image = contact.editImage{
                    Image(uiImage:image).resizable().aspectRatio(contentMode: .fit)
                }
            }.onTapGesture {
                showImagePicker = true
            }
            TextField("Name", text: $contact.editName)
            TextField("Number", text: $contact.editNumber)
        }.navigationBarItems(trailing:Button("Save"){
            
            //authenticate the save
            authenticateSave()            
        })
        .onChange(of: inputImage){_ in loadImage()}
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $inputImage)
        }
        //If the user hides the view before saving, then we cancel changes
        .onDisappear(perform:{
            contact.editName = contact.name
            contact.editNumber = contact.number
            contact.editImage = contact.image
        })
    }
    
    func authenticateSave() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        print("authenticated")
                        contact.name = contact.editName
                        contact.number = contact.editNumber
                        contact.image = contact.editImage
                        
                    } else {
                        // there was a problem
                        print("not authenticated")
                    }
                    dismiss()
                }
            }
            print("biometrics")
        } else {
            // no biometrics
            print("no biometrics")
            DispatchQueue.main.async {
                // there was a problem
                print("not authenticated")
                dismiss()
            }
        }
    }
}

#Preview {
    ContactDetailView(contact:Contact(name:"Example", number:"012345"))
}
