//
//  Contact.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import Foundation
class Contact:Identifiable, ObservableObject,Codable{
    let id = UUID()
    @Published var name:String
    @Published var number:String
    var editName:String
    var editNumber:String
    
    init (name:String, number:String){
        self.name = name
        self.number = number
        self.editName = name
        self.editNumber = number
    }
    
    
    enum CodingKeys:CodingKey{
        case name, number, id
    }
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let loadedName = try container.decode(String.self, forKey: .name)
        let loadedNumber = try container.decode(String.self, forKey: .number)
        name = loadedName
        number = loadedNumber
        editName = loadedName
        editNumber = loadedNumber
    }
}
