//
//  ContentView.swift
//  UserDataForms
//
//  Created by hemanth.p on 20/01/25.
//

import SwiftUI

struct Users: Identifiable {
    var id = UUID()
    let firstName: String
    let lastName: String
    let gender: String
    let email: String
    let phone: String
    let DOB: Date
}

class UsersViewModel: ObservableObject {
    @Published var users: [Users] = []
    
    func addUser(user: Users){
        let user = Users(firstName: user.firstName, lastName: user.lastName, gender: user.gender, email: user.email, phone: user.phone, DOB: user.DOB)
        users.append(user)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = UsersViewModel()
    @State private var userScene = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(viewModel.users){user in
                        
                        NavigationLink(destination: UserDetail(user: user, viewModel: viewModel)){
                            Text("\(user.firstName) \(user.lastName)")
                                .bold()
                                .lineLimit(1)
                                .frame(maxWidth: .infinity)
                                .padding(EdgeInsets(top: 24, leading: 32, bottom: 24, trailing: 32))
                                .foregroundColor(.white)
                                .background(Color(red: 0.557, green: 0.557, blue: 0.578))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                                .cornerRadius(8)
                            
                        }
                        Divider()
                        
                    }
                    
                    if viewModel.users.isEmpty{
                        Text("No Records Found")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Click \(Image(systemName: "person.fill.badge.plus")) to add user")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .navigationTitle("Users List")
                .navigationBarItems(
                    trailing: Group {
                        Button("\(Image(systemName: "person.fill.badge.plus"))"){
                            userScene = true
                        }
                        .sheet(isPresented: $userScene){
                            UserFormsTemp(viewModel: viewModel, isPresented: $userScene, user: nil){newUser in
                                viewModel.users.append(newUser)
                            }
                        }
                    }
                )
                
                Spacer()
            }
        }
    }
    
}

#Preview {
    ContentView()
}

//UserCard(firstName: "Add", lastName: "User", destination: UserForms(viewModel: viewModel))
/*NavigationLink(destination: UserForms(viewModel: viewModel)){
    Text("Add User")
        .frame(maxWidth: 100)
        .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(Capsule())
}
*/

/*
Button("\(Image(systemName: "person.fill.badge.plus"))"){
    userScene = true
}
.frame(maxWidth: 100)
.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
.foregroundColor(.white)
.background(Color.blue)
.clipShape(Capsule())
.sheet(isPresented: $userScene, onDismiss: {
    
}){
    UserForms(viewModel: viewModel)
}
 */

/*
ForEach(1...15, id: \.self){index in
    UserCard(firstName: "FirstName", lastName: "LastName", destination: SwiftUIView())
}
*/

//UserCard(firstName: user.firstName, lastName: user.lastName, destination: UserDetail(user: user))
