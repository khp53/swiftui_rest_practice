//
//  image_viewmodel.swift
//  newsapp
//
//  Created by Karimul Hasan on 1/9/22.
//

import Foundation
import SwiftUI

class ImageViewmodel: ObservableObject {
    
    @Published var imgData: Data?
    
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            [weak self] data, _, _ in
            self?.imgData = data
        }
        task.resume()
    }
}
