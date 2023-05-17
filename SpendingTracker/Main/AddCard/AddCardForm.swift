//
//  AddCardForm.swift
//  SpendingTracker
//
//  Created by Yigit Karakurt on 16.05.2023.
//

import SwiftUI

struct AddCardForm: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var cardNumber = ""
    @State private var limit = ""
    
    @State private var cardType = "Visa"
    
    @State private var month = 1
    @State private var year = Calendar.current.component(.year, from: Date())
    @State private var color = Color.blue
    
    let currentYear = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("CARD INFORMATION")){
                    
                    TextField("Name", text: $name)
                    TextField("Credit Card Number", text: $cardNumber)
                        .keyboardType(.numberPad)
                    TextField("Credit Limit", text: $limit)
                        .keyboardType(.numberPad)
                    
                    Picker("Type", selection: $cardType) {
                        ForEach(["Visa", "Mastercard", "Discover"], id: \.self) { cardType in
                            Text(String(cardType)).tag(String(cardType))
                        }
                        
                    }
                    
                }
                
                Section(header: Text("EXPIRATION")){
                    Picker("Month", selection: $month) {
                        ForEach(1..<13, id: \.self) { num in
                            Text(String(num)).tag(String(num))
                        }
                    }
                    Picker("Year", selection: $year) {
                        ForEach(currentYear..<currentYear+25, id: \.self) { num in
                            Text(String(num)).tag(String(num))
                        }
                    }
                }
                
                Section(header: Text("CARD COLOR")){
                    ColorPicker("Color", selection: $color)
                }
            }
                .navigationTitle("Add Credit Card")
                .navigationBarItems(leading: cancelButton, trailing: saveButton )
        }
    }
    
    var cancelButton: some View{
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
    }
    
    var saveButton: some View{
        Button(action: {
            let viewContext = PersistenceController.shared.container.viewContext
            let card = Card(context: viewContext)
            card.name = self.name
            card.number = self.cardNumber
            card.limit = Int32(self.limit) ?? 0
            card.expMonth = Int16(self.month)
            card.expYear = Int16(self.year)
            card.timestamp = Date()
            card.color = UIColor(self.color).encode()
            card.type = self.cardType
            
            do{
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            }catch{
                print("Failed to persist new card: \(error.localizedDescription)")
            }
            
            
        }, label: {
            Text("Save")
        })
    }
}

extension UIColor {
    
    class func color(data: Data) -> UIColor? {
        return try?
        NSKeyedUnarchiver
            .unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

struct AddCardForm_Previews: PreviewProvider {
    static var previews: some View {
//        AddCardForm()
        let context = PersistenceController.shared.container.viewContext
        MainView()
            .environment(\.managedObjectContext, context)
    }
}
