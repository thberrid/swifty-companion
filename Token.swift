//
//  Token.swift
//  swifty-companion
//
//  Created by thberrid on 21/06/2021.
//  Copyright © 2021 thberrid. All rights reserved.
//

import Foundation

struct Token {
    
    static var str: String?

    func set(completion: @escaping () -> Void) {
        print("getTOKEN")
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials&client_id=CLIENTID&client_secret=CLIENTSECRET".data(using: .utf8)!
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let data = data, let dataArray = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                Token.str = dataArray["access_token"] as! String?
                //print(Token.str!)
            } else {
                print("getTOKEN ERROR")
            }
            completion()
        }.resume()
    }
    
}
