//
//  ContentView.swift
//  Task
//
//  Created by CEPL on 10/10/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    @State private var joke: String = ""

    var body: some View {
           Text(joke)
            .font(.system(size: 30))
            .padding(30)
            .onAppear {
                callFunc()
            }
           Button {
               Task {
                   // For First Time
                   // Call API
                   callAPI()
               }
           } label: {
               Text("Get Joke")
           }
       }
    
    
    func callFunc() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                print("-----> callFunc")
                //  Auto Call API after 30 Second
                callAPI()
                
                // Repeated Call of DispatchQueue function
                callFunc()
            }
        }
    
    func callAPI() {
        
        // Api Request
        AF.request("https://geek-jokes.sameerkumar.website/api").response {
            response in
            var json = response.data
            debugPrint(response)
            if let data = response.data {
                // Convert respponse data in String by using Encoding.utf8
                joke = String(data: data, encoding: String.Encoding.utf8) ?? ""
                print(joke)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

