//
//  ProfileView.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//
import SwiftUI
import UIKit

struct ProfileView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var isEditingProfile = false
    @State private var newUsername = "John Doe"
    @State private var newEmail = "johndoe@example.com"
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Welcome back, \(newUsername)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.green)
                .padding()
            // Profile picture placeholder
            Image(uiImage: selectedImage ?? UIImage(systemName: "person.circle")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(.top, 50)
                .onTapGesture {
                    isImagePickerPresented = true
                }
            
            // Other user information
            Text("Username: \(newUsername)")
            Text("Email: \(newEmail)")

            // Edit profile button
            Button(action: {
                isEditingProfile = true
            }) {
                Text("Edit Profile")
                    .foregroundColor(.blue)
                    .padding(.top, 5)
            }
            .popover(isPresented: $isEditingProfile, arrowEdge: .bottom) {
                VStack {
                    HStack {
                        Text("New Username:")
                        TextField("Enter new username", text: $newUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("New Email:")
                        TextField("Enter new email", text: $newEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button(action: {
                        // Save changes
                        // For example:
                        // viewModel.updateUsername(newUsername)
                        // viewModel.updateEmail(newEmail)
                        isEditingProfile = false
                    }) {
                        Text("Save Changes")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }

            // Purchase history section
            Text("Purchase History")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.green)
            List(viewModel.purchaseHistory, id: \.id) { item in
                VStack(alignment: .leading) {
                    HStack{
                        VStack{
                            Text(item.name)
                            Text("Size: \(item.size)")
                            Text("$\(String(format: "%.2f", item.price))")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        // Display item image
                        Image(item.name) // Assuming item.name corresponds to the image name in your assets catalog
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.trailing)
                    }
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
    }
}
