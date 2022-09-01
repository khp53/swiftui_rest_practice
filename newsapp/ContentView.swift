//
//  ContentView.swift
//  newsapp
//
//  Created by Karimul Hasan on 1/9/22.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .frame(width: 120, height: 60)
                .background(Color.gray)
        } else {
            ProgressView()
                .frame(width: 120, height: 60)
                .background(Color.gray)
                .onAppear{
                    fetchImage(urlString: urlString)
                }
            
        }
    }
    
    // fetch image
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var vm = Viewmodel()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.posts, id: \.self) {
                    post in
                    HStack {
                        URLImage(urlString: post.image)
                        Text(post.name).bold()
                    }.padding(2)
                }
            }.navigationTitle("News Posts")
                .onAppear{
                    vm.fetch()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
