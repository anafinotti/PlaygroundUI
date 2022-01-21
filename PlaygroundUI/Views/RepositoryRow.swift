//
//  RepositoryRow.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import SwiftUI

struct RepositoryRow: View {
    
    @ObservedObject var imageLoader = ImageLoaderService()
    
    @State var image: UIImage = UIImage()
    
    var repository: RepositoryModel

    var body: some View {
        HStack {
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50, height:50)
                .onReceive(imageLoader.$image) { image in
                    self.image = image
                }
                .onAppear {
                    imageLoader.loadImage(for: self.repository.owner?.avatarUrl ?? "")
                }
            Text(repository.name ?? "")

            Spacer()
        }
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepositoryRow(repository: RepositoryModel(id: 1233, name: "SwiftUI POD", owner: OwnerModel(id: 1, avatarUrl: "https://avatars.githubusercontent.com/u/36260787?v=4", url: "https://api.github.com/users/CyC2018", login: "John"), url: "https://api.github.com/repos/CyC2018/CS-Notes", description: "Leetcod Lorem Ipsum"))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
