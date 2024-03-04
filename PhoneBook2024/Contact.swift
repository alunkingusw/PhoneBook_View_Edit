//
//  Contact.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import Foundation
import SwiftUI

class Contact:Identifiable, ObservableObject,Codable{
    let id = UUID()
    @Published var name:String
    @Published var number:String
    @Published var image:UIImage?
    var editName:String
    var editNumber:String
    @Published var editImage:UIImage?
    
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
        writeImageToDisk()
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
        //load image from disk if it exists!
        let imagePath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false).appendingPathComponent("\(number).jpg")
        
        if let loadPath = imagePath{
            print(loadPath)
            if let data = try? Data(contentsOf: loadPath){
                self.image = UIImage(data: data)
                print("loaded")
            }
        }
            
    }
    
    func writeImageToDisk() {
        if let imageToSave = self.image{
            let imagePath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false).appendingPathComponent("\(number).jpg") //Use the UUID for the image name.
            if let jpegData = imageToSave.jpegData(compressionQuality: 0.5) { // I can adjust the compression quality.
                if let savePath = imagePath{
                    try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
                    print("saved \(savePath)")
                }
            }
        }
    }
    
}
