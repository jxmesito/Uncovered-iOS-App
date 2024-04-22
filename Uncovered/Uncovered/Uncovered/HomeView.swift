//
//  HomeView.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack{
                    Text("Uncovered World") // Add the title
                        .font(.largeTitle) // Set the font size
                        .fontWeight(.bold) // Make the text bold
                        .foregroundColor(.green)
                        .padding(.top, 20) // Add top padding
                        .frame(maxWidth: .infinity) // Expand to full width
                    Spacer() // Add spacer to push the title to the left
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                            ForEach(viewModel.imageNames, id: \.self) { imageName in
                                if let box = viewModel.boxes.first(where: { $0.name == imageName }) {
                                    BoxView(box: box, imageName: imageName, viewModel: viewModel)
                                        .padding(2)
                                        .background(Color.white) // Set individual box background to black
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                            }
                        }
                        .padding(.horizontal, 20) // Adjust horizontal padding
                        .frame(width: geometry.size.width) // Set width to screen width
                    }
                    .padding(.trailing) // Add trailing padding to align scrollbar to the right edge
                }
            }
        }
    }
}
