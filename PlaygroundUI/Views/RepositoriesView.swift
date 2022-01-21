//
//  RepositoriesView.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import SwiftUI

struct RepositoriesView: View {
    
    @ObservedObject var repositoryViewModel = RepositoryViewModel()

    var body: some View {
        
        NavigationView {
            
            List(repositoryViewModel.repositoryList.repositories ?? [RepositoryModel]()) { repository in
                
                NavigationLink {
                    RepositoryDetailView(repository: repository)
                } label: {
                    RepositoryRow(repository: repository)
                }
            }
            .navigationTitle("Repositories")
        }
    }
}
