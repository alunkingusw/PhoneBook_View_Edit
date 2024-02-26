//
//  PhoneBook2024App.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import SwiftUI

@main
struct PhoneBook2024App: App {
    @StateObject private var data = Contacts()
    var body: some Scene {
        WindowGroup {
            PhoneBookView(data:self.data){
                Contacts.save(contacts: data.contacts){ result in
                    if case .failure(let error) = result{
                        fatalError(error.localizedDescription)
                    }
                }
            }.onAppear{
                Contacts.load{ result in
                    switch result{
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let contacts):
                        data.contacts = contacts
                    }
                    
                }
            }
        }
    }
}
