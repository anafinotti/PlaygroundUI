//
//  RepositoryDetail.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import SwiftUI

struct RepositoryDetailView: View {
    
    @ObservedObject var imageLoader = ImageLoaderService()
    
    @State var image: UIImage = UIImage()
    @State var repository: RepositoryModel
    
    init(repository: RepositoryModel) {
        
        self.repository = repository
    }
    
    var body: some View {
        
        ScrollView {
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay {
                    Circle().stroke(.white, lineWidth: 1)
                }
                .shadow(radius: 2)
                .onReceive(imageLoader.$image) { image in
                    self.image = image
                }
                .onAppear {
                    imageLoader.loadImage(for: self.repository.owner?.avatarUrl ?? "")
                }
            
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.title)
                
                HStack {
                    Text(repository.description ?? "")
                    Spacer()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("Owner").font(.title)
                Text(repository.owner?.login ?? "")

            }
            .padding()
        }
        .navigationTitle(repository.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        
        RepositoryDetailView(repository: RepositoryModel(id: 1233, name: "SwiftUI POD", owner: OwnerModel(id: 1, avatarUrl: "https://avatars.githubusercontent.com/u/36260787?v=4", url: "https://api.github.com/users/CyC2018", login: "John"), url: "https://api.github.com/repos/CyC2018/CS-Notes", description: "Leetcod Lorem Ipsum"))
    }
}
