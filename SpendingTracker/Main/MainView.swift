//
//  MainView.swift
//  SpendingTracker
//
//  Created by Yigit Karakurt on 15.05.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                
                VStack (alignment: .leading, spacing: 16){
                    Text("Apple Blue Visa Card")
                        .font(.system(size: 24, weight: .semibold))
                    HStack{
                        Image("visa")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 44)
                            .clipped()
                        Spacer()
                        Text("Balance: 50.000$")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    
                    
                    
                    Text("1234 1234 1234 1234")
                    
                    Text("Credit Limit: 50.000$")
                    
                    HStack{ Spacer() }
                    
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .shadow(radius: 5)
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing: addCardButton)
        }
        
        
    }
    
    var addCardButton: some View{
        Button(action: {
            
        }, label: {
            Text("+ Card")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .background(Color.black)
                .cornerRadius(5)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
