//
//  Model.swift
//  Task
//
//  Created by CEPL on 10/10/22.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class Model: ObservableObject{
    @State private var joke: String = ""
    func getJoke() -> String{

        // Api Request
        AF.request("https://geek-jokes.sameerkumar.website/api").response { [self]
            response in
            var json = response.data
            debugPrint(response)
            if let data = response.data {
                // Convert respponse data in String by using Encoding.utf8
                self.joke = String(data: data, encoding: String.Encoding.utf8) ?? ""
                print(joke)
            }else{
                
            }
        }
        if(joke)
        return self.joke
    }
}
