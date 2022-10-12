//
//  ContentView.swift
//  Task
//
//  Created by CEPL on 10/10/22.
//

import Foundation
import SwiftUI
import CoreData
import Alamofire

struct ContentView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var jokeListVM: JokeListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var sjoke: String = ""
    
    // New
    
    init(vm: JokeListViewModel){
        self.jokeListVM = vm
    }
    
    var body: some View{
        NavigationView{
            VStack{
                Text(sjoke)
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .padding(15)
                    .onAppear {
                        callFunc()
                    }
                List{
                    ForEach(jokeListVM.jokess){
                        jokes in
                        Text(jokes.joke)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        
                    }
                }.padding(20)
            }
            .navigationTitle("Jokes")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Fetch Jokes!!!"){
                       // isPresented = true
                        callAPI()
                    }.frame(width: 130, height: 50)
                        .background(Color.white)
                }
            }
        }
        
    }

    func callFunc() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                    print("-----> callFunc")
                    // You can change here time delay
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
                   sjoke = String(data: data, encoding: String.Encoding.utf8) ?? ""
                   print(sjoke)
                   jokeListVM.joke = sjoke
                   jokeListVM.save()
                   presentationMode.wrappedValue.dismiss()
               }
           }
       }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.presistentStoreContainer.viewContext
        ContentView(vm: JokeListViewModel(context: viewContext))
    }
}



