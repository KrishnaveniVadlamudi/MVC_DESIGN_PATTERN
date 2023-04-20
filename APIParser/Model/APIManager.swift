//
//  APIManager.swift
//  APIParser
//
//  Created by Sunkara on 4/17/23.
//

import Foundation
protocol Response {
    func didReceiveResponse(_: [Todo])
}

enum ParserStatus: String {
    case Failed,Success
}

struct TodoResponse : Codable{
    let todos: [Todo]
    let total, skip, limit: Int
}


struct Todo : Codable {
    let id: Int?
     let todo: String?
     let completed: Bool?
     let userID: Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case todo = "todo"
        case completed = "completed"
        case userID = "userId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
   
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        todo = try values.decodeIfPresent(String.self, forKey: .todo)
        completed = try values.decodeIfPresent(Bool.self, forKey: .completed)
        userID = try values.decodeIfPresent(Int.self, forKey: .userID)
    }

}

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    private override init() { }

    
    func getAllTodos(urlStr : String,withCompletion completion:@escaping ([Todo]) -> Void) {
        let url = URL(string: urlStr)
        let urlReq = URLRequest(url: url!)
         URLSession.shared.dataTask(with: urlReq, completionHandler:{
            (data,response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode)
            else {
                print("Rsponse is \(String(describing:response))")
                return
                
            }
             
             print("response Satus Code is\(response.statusCode)")
             
             guard let data1 = data else { return}
             print("Data is \(String(describing: data))")
             do {
                 let decoder = JSONDecoder()
                 let modelObj = try decoder.decode(TodoResponse.self, from: data!)
                 print("TodoResponse \(TodoResponse.self)")
               //  completionHandler(modelObj.todos )
                // self.toDosArray =  modelObj.todos
                DispatchQueue.main.async {
                    completion(modelObj.todos)
               }
                
             }
             catch {
                 print("Erroro in decoding JSON......\(error.localizedDescription)")
             }
         }
         ).resume()}
    
    
}
