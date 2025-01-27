//
//  UserFormsTemp.swift
//  UserDataForms
//
//  Created by hemanth.p on 24/01/25.
//

import SwiftUI

struct UserFormsTemp: View {
    @ObservedObject var viewModel: UsersViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isPresented: Bool
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date.now
    @State private var curGender = "Other"
    @State private var emailID = ""
    @State private var phone = ""
    @State private var isValid = false
    
    var user: Users?
    var onSave: (Users) -> Void
    
    init(viewModel: UsersViewModel, isPresented: Binding<Bool>, user: Users? = nil, onSave: @escaping (Users) -> Void){
        self.viewModel = viewModel
        self._isPresented = isPresented
        self.user = user
        self.onSave = onSave
        
        if let user = user {
            _firstName = State(initialValue: String(user.firstName))
            _lastName = State(initialValue: user.lastName)
            _birthDate = State(initialValue: user.DOB)
            _curGender = State(initialValue: user.gender)
            _emailID = State(initialValue: user.email)
            _phone = State(initialValue: user.phone)
        }
        
    }
    
    let genderOptions = ["Male", "Female", "Other", "Prefer not to say"]
    
    var body: some View {
        
        NavigationStack{
            Form{
                Section{
                    VStack{
                        TextField("First Name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                } header: {
                    Text("Name")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Section{
                    DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date){
                        Text("Date of Birth")
                            .bold()
                            .frame(alignment: .leading)
                        //.datePickerStyle(.graphical)
                    }
                }
                
                Section{
                    HStack {
                        Text("Gender")
                            .bold()
                        Spacer()
                        Picker("", selection: $curGender){
                            ForEach(genderOptions, id: \.self){option in
                                Text(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Section{
                    TextField("\(String("example@gmail.com"))", text: $emailID)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                } header: {
                    HStack{
                        Text("Email ID")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if isValidEmail(emailID){
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        } else if !emailID.isEmpty && !isValidEmail(emailID){
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                            
                        }
                    }
                }
                
                Section{
                    TextField("Enter number", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } header: {
                    HStack{
                        Text("Mobile Number")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                        if isValidPhone(phone){
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                        else if !phone.isEmpty && !isValidPhone(phone){
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                            
                        }
                        
                    }
                }

                Button("Submit") {
                    submit()
                }
                .alert(isPresented: $isValid){
                    Alert(title: Text("Invalid email or phone number"),
                          dismissButton: .default(Text("OK")))
                }
                .disabled(!(isValidEmail(emailID) && isValidPhone(phone)))
                
                Button("Populate"){
                    populateDataForms()
                }
                
            }
            
            .navigationTitle("Personal Information")
            .navigationBarItems(
                trailing: Button("Cancel"){
                    isPresented = false
                }
            )
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    func populateDataForms(){
        firstName = "Hemanth"
        lastName = "Palani"
        curGender = "Male"
        emailID = "Hems@gmail.com"
        phone = "9150998077"
    }
    
    func submit(){
        if (!isValidEmail(emailID) || !isValidPhone(phone)){
            isValid = true
            return
        }
        
        let updatedUser = Users(id: user?.id ?? UUID(), firstName: firstName, lastName: lastName, gender: curGender, email: emailID, phone: phone, DOB: birthDate)
        
        onSave(updatedUser)
        isPresented = false
        
    }
}

#Preview {
    UserFormsTemp(viewModel: UsersViewModel(), isPresented: .constant(true)){_ in }
}

/*
 
 func prePopulate(user: Users? = nil) {
     if let curUser = user{
         firstName = curUser.firstName
         lastName = curUser.lastName
         curGender = curUser.gender
         emailID = curUser.email
         phone = curUser.phone
         birthDate = curUser.DOB
     }
 }
 
 if (!isValidEmail(emailID) || !isValidPhone(phone)){
     isValid = true
     return
 }
 
 viewModel.addUser(firstName: firstName, lastName: lastName, gender: curGender, email: emailID, phone: phone, DOB: birthDate)
 
 isPresented = false
 */

/*
 if let curUser = user{
     if let index = viewModel.users.firstIndex(where: {$0.id == curUser.id}){
         viewModel.users[index] = updatedUser
     }
 }
 else{
     viewModel.addUser(user: updatedUser)
 }
 */
