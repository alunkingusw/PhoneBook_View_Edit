//
//  Contacts.swift
//  PhoneBook2024
//
//  Created by Alun King on 12/02/2024.
//

import Foundation
class Contacts:ObservableObject{
    @Published var contacts:[Contact] = []
    
    private static func fileURL() throws -> URL{
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            .appendingPathComponent("contacts.data")
    }
    
    
    
    static func save(contacts:[Contact], completion: @escaping (Result<Int, Error>)->Void){
        DispatchQueue.global(qos: .background).async{
            do{
                let data = try JSONEncoder().encode(contacts)
                let outfile = try fileURL()
                try data.write(to:outfile)
                DispatchQueue.main.async{
                    completion(.success(contacts.count))
                }
            }catch {
                DispatchQueue.main.async{
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Contact], Error>)->Void){
        DispatchQueue.global(qos: .background).async{
            do{
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async{
                        completion(.success([]))
                    }
                        return
                    }
                let newContact = try JSONDecoder().decode([Contact].self, from: file.availableData)
                DispatchQueue.main.async{
                    completion(.success(newContact))
                    }
            }catch{
                DispatchQueue.main.async{
                    completion(.failure(error))
                }
            }
        }
    }
}
