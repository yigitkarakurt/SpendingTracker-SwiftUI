//
//  AddCardForm.swift
//  SpendingTracker
//
//  Created by Yigit Karakurt on 16.05.2023.
//

import SwiftUI

struct AddCardForm: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        NavigationView{
            Form{
                Text("Add Card Form")
            }
                .navigationTitle("Add Credit Card")
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                }))
        }
    }
}

struct AddCardForm_Previews: PreviewProvider {
    static var previews: some View {
        AddCardForm()
    }
}
