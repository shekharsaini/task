//
//  ContentViewModel.swift
//  Task
//
//  Created by CEPL on 10/10/22.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject{
   
    var model: Model
    
    @Published var joke: String = ""
    
    init(model:Model) {
        self.model = model
    }
    
    func getJoke()-> String  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: {
            [weak self] in
            self?.joke = (self?.model.getJoke())! ?? ""
        })
        
        return self.joke
    }
    
    func callAPI() -> String {
        DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: { [self] in
            self.joke = self.model.getJoke()
        })
        
        return self.joke
    }
    
}
