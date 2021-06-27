//
//  UserData.swift
//  swifty-companion
//
//  Created by thberrid on 6/12/21.
//  Copyright © 2021 thberrid. All rights reserved.
//

import Foundation
import UIKit

class UserData {
    
    var jsonData: Response?
    var token = Token()
    
    func get(login: String, completion: @escaping () -> Void){
        print("getUserData")
        if Token.str == nil {
            token.set { self.get(login: login, completion: completion) }
        } else {
            print("getUSerData 2")
            print(login)
            let url = URL(string: "https://api.intra.42.fr/v2/users/" + login)!
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer " + Token.str!, forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request){ (data, response, error) in
                if let data = data {

                    self.jsonData = try? JSONDecoder().decode(Response.self, from: data)
                    //if let _ = self.jsonData { print(self.jsonData!) } else { print("decoding error") }
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }.resume()
        }
    }
    
}
