//
//  viewmodel.swift
//  newsapp
//
//  Created by Karimul Hasan on 1/9/22.
//

import Foundation
import SwiftUI

class Viewmodel: ObservableObject {
    @Published var posts: [ModelData] = []
    
    func fetch() {
        guard let url = URL(string: "INSERT_API_HERE) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in guard let data = data, error == nil else {
            return
        }
            // convert to json
            do {
                let posts = try JSONDecoder().decode([ModelData].self, from: data)
                DispatchQueue.main.async {
                    self?.posts = posts
                    
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
