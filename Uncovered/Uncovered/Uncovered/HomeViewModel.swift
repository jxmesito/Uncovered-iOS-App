//
//  BoxViewModel.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var cartItems: [Box] = []
    @Published var favoriteItems: [Box] = []
    @Published var purchaseHistory: [Box] = []
    @Published var imageNames: [String] = ["shirt_1", "shirt_2", "shirt_3","shirt_4","shirt_5","shirt_6","shirt_7","shirt_8","gloves_1", "short_1"]

        // Define your Box objects here
        var boxes: [Box] = [
            Box(name: "shirt_1", price: 20.0, size: 0),
            Box(name: "shirt_2", price: 20.0, size: 0),
            Box(name: "shirt_3", price: 20.0, size: 0),
            Box(name: "shirt_4", price: 20.0, size: 0),
            Box(name: "shirt_5", price: 20.0, size: 0),
            Box(name: "shirt_6", price: 20.0, size: 0),
            Box(name: "shirt_7", price: 20.0, size: 0),
            Box(name: "shirt_8", price: 20.0, size: 0),
            Box(name: "gloves_1", price: 15.0, size: 0),
            Box(name: "short_1", price: 25.0, size: 0)
            // Add more Box objects as needed
        ]
    
    func addToCart(_ box: Box, size: Int) {
        var boxWithSize = box
        boxWithSize.size = size + 1 // Add size to the box before adding to cart
        cartItems.append(boxWithSize)
    }
    
    func purchaseItems() {
            // Move items from cart to purchase history
            purchaseHistory.append(contentsOf: cartItems)
            // Clear cart after purchase
            cartItems.removeAll()
    }
    
    func removeAllItemsFromCart() {
        cartItems.removeAll()
    }
    
    func removeFromCart(_ box: Box) {
        if let index = cartItems.firstIndex(where: { $0.id == box.id }) {
            cartItems.remove(at: index)
        }
    }
    
    func addToFavorites(_ box: Box) {
        favoriteItems.append(box)
    }
    
    func isInFavorites(_ box: Box) -> Bool {
        return favoriteItems.contains(where: { $0.id == box.id })
    }
    
    func removeFromFavorites(_ box: Box) {
        if let index = favoriteItems.firstIndex(where: { $0.id == box.id }) {
            favoriteItems.remove(at: index)
            print("Item removed from favorites") // Add a print statement to verify removal
        } else {
            print("Item not found in favorites") // Add a print statement to debug if the item is not found
        }
    }
}

struct Box: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    var size: Int
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to update the view controller
    }
}
