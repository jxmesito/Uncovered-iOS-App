//
//  CartView.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var total: Double {
        viewModel.cartItems.reduce(0) { $0 + $1.price }
    }
    
    // Function to convert number to corresponding letter size
    func sizeLetter(from number: Int) -> String {
        switch number {
        case 1: return "XXS"
        case 2: return "XS"
        case 3: return "S"
        case 4: return "M"
        case 5: return "L"
        case 6: return "XL"
        case 7: return "XXL"
        default: return "Unknown"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                List(viewModel.cartItems, id: \.id) { item in
                    HStack {
                        // Display item image
                        Image(item.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text("Size: \(sizeLetter(from: item.size))") // Display corresponding letter size
                            Text("Price: $\(String(format: "%.2f", item.price))")
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.removeFromCart(item)
                            // Provide haptic feedback
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.prepare()
                            generator.impactOccurred()
                        }) {
                            Image(systemName: "x.circle")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
                .navigationBarTitle("Cart")
                
                // Display total
                Text("Total: $\(String(format: "%.2f", total))")
                    .font(.headline)
                    .padding(.bottom)
                
                Button(action: {
                    viewModel.removeAllItemsFromCart()
                    // Provide haptic feedback
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }) {
                    Text("Remove All Items")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewModel.purchaseItems()
                }) {
                    HStack {
                        Text("Purchase")
                            .foregroundColor(.blue)
                            .padding()
                        Spacer()
                        Image(systemName: "cart")
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}
