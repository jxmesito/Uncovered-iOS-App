//
//  BoxView.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//

import SwiftUI

struct BoxView: View {
    @State private var selectedSize = "M" // Default size
    @State private var isAddedToFavorites = false
    @State private var isShowingEnlargedView = false

    let box: Box
    let imageName: String
    @ObservedObject var viewModel: HomeViewModel
    
    let sizes = ["XXS", "XS", "S", "M", "L", "XL", "XXL"]

    var body: some View {
        VStack {
            Button(action: {
                isShowingEnlargedView.toggle()
            }) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            .sheet(isPresented: $isShowingEnlargedView) {
                // Present modal view with enlarged image
                EnlargedImageView(imageName: imageName)
            }

            Text(String(format: "$%.2f", box.price))
                .foregroundColor(.green)

            HStack {
                Picker("Size", selection: $selectedSize) {
                    ForEach(sizes, id: \.self) { size in
                        Text(size)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 80)

                Button(action: {
                    // Convert selected size to an integer value if needed
                    let sizeIndex = sizes.firstIndex(of: selectedSize) ?? 0
                    viewModel.addToCart(self.box, size: sizeIndex)
                    // Provide haptic feedback
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }) {
                    Image(systemName: "cart")
                        .foregroundColor(.green)
                        .padding()
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .onAppear {
            isAddedToFavorites = viewModel.isInFavorites(self.box)
        }
    }
}


struct EnlargedImageView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
