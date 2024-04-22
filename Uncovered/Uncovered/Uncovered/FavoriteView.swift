//
//  FavoriteView.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteItems, id: \.id) { item in
                Text(item.name)
            }
            .navigationBarTitle("Favorites")
        }
    }
}
