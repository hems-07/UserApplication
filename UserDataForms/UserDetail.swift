import SwiftUI

struct UserDetail: View {
    
    @State var user: Users
    @State private var isEdit = false
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
            
            ScrollView{

                VStack (spacing: 20) {
                    VStack {
                        Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
                            .frame(width: 100, height: 100)
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                            .background(Color(hue: 0.667, saturation: 0.026, brightness: 0.42))
                            .clipShape(Circle())
                            .shadow(radius: 7)
                        
                        Text("\(user.firstName) \(user.lastName)")
                            //.lineLimit(1)
                            .padding()
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 70)
                    .padding(.bottom, 20)
                    .background(.gray)
                    .frame(maxWidth: .infinity)
                 
                    VStack(alignment: .leading, spacing: 10){
                        displayDetail(headerText: "Gender", text: "\(user.gender)")
                        displayDetail(headerText: "Email ID", text: "\(user.email)")
                        displayDetail(headerText: "Mobile", text: "\(user.phone)")
                        displayDetail(headerText: "DOB", text: "\(shortDate(user.DOB))")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    Spacer()
                }
                .padding()
                //.frame(maxWidth: .infinity)
            
            }
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        isEdit = true
                        print("Edited")
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .bold()
                            .foregroundStyle(.white)
                            //.foregroundStyle(Color(red: 0.408, green: 0.408, blue: 0.421))
                            .shadow(radius: 8)
                    }
                    .sheet(isPresented: $isEdit){
                        UserFormsTemp(viewModel: viewModel, isPresented: $isEdit, user: user) {updatedUser in updateUser(updatedUser: updatedUser)
                        }
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward.2")
                                .bold()
                                .foregroundStyle(.white)
                                //.foregroundStyle(Color(red: 0.408, green: 0.408, blue: 0.421))
                                .shadow(radius: 8)
                        }
                    }
                }
                
                
            }
        }
    }
    
    func updateUser(updatedUser: Users){
        
        if let index = viewModel.users.firstIndex(where: {$0.id == user.id}){
            viewModel.users[index] = updatedUser
            user = updatedUser
        }
    }
    
    func shortDate(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func displayDetail(headerText: String, text: String) -> some View {
        VStack (alignment: .leading, spacing: 10){
            Text("\(headerText)")
                .bold()
                .foregroundStyle(.gray)
                .font(.system(size: 14))
            Text("\(text)")
            Divider()
        }
    }

    
}


#Preview {
    UserDetail(user: Users(
        firstName: "FirstName", lastName: "LastName", gender: "Male", email: "abc@gmail.com", phone: "xxxxxxxxxx", DOB: Date.now
    ), viewModel: UsersViewModel())
}

/*
 .toolbar {
     ToolbarItem(placement: .navigationBarLeading){
         Button(action: {}){
             Image(systemName: "arrowtriangle.left.fill")
                 .foregroundStyle(Color(hue: 0.667, saturation: 0.026, brightness: 0.42))
             //Image(systemName: "arrowshape.left.circle")
         }
     }
 }
 */


/*VStack{
 List{
 //displayDetail(headerText: "Name", text: "\(user.firstName) \(user.lastName)")
 displayDetail(headerText: "Gender", text: "\(user.gender)")
 displayDetail(headerText: "Email ID", text: "\(user.email)")
 displayDetail(headerText: "Mobile", text: "\(user.phone)")
 displayDetail(headerText: "DOB", text: "\(shortDate(user.DOB))")
 }
 .listStyle(.inset)
 }
 */

/*
struct displayDetail: View {
    var headerText: String
    var text: String
    
    var body: some View {
        Section{
            Text("\(text)")
        } header: {
            Text("\(headerText)")
        }
        .listRowSeparator(.hidden)
    }
}*/

//private var user = Users(firstName: "First Name", lastName: "Last Name", gender: "Others", email: "Example@gmail.com", phone: "9150998077", DOB: Date.now)
