//
//  MainView.swift
//  SpendingTracker
//
//  Created by Yigit Karakurt on 15.05.2023.
//

import SwiftUI



struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Card.timestamp, ascending: true)],
        animation: .default)
    private var cards: FetchedResults<Card>
    
    @State private var shouldPresentAddCardForm = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !cards.isEmpty{
                    TabView{
                        ForEach(cards){ card in
                            CreditCardView(card: card)
                                .padding(.bottom, 50)
                        }
                    
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 280)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                }
                
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldPresentAddCardForm) {
                        AddCardForm()
                    }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(leading: HStack {
                addItemButton
                deleteAllButton
            } , trailing: addCardButton)
        }
    }
    
    struct CreditCardView: View{
        
        let card: Card
        var body: some View{
            VStack (alignment: .leading, spacing: 16){
                Text(card.name?.capitalized ?? "")
                    .font(.system(size: 24, weight: .semibold))
                HStack{
                    Image(card.type ?? "Visa")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                        .clipped()
                    Spacer()
                    Text("Balance: 50.000$")
                        .font(.system(size: 18, weight: .semibold))
                }
                
                
                
                Text(card.number ?? "")
                
                Text("Credit Limit: $\(card.limit)")
                
                HStack{ Spacer() }
                
            }
            .foregroundColor(.white)
            .padding()
            .background(
                
                VStack{
                    
                    if let colorData = card.color,
                        let uiColor = UIColor.color(data: colorData),
                        let actualColor = Color(uiColor) {
                        
                        LinearGradient(colors: [actualColor.opacity(0.4),
                            actualColor],
                            startPoint: .top,
                            endPoint: .bottom)
                    } else {
                        Color.purple
                    }
                }
                
                
            )
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black.opacity(0.5), lineWidth: 1))
            .cornerRadius(8)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
    
    
    var addCardButton: some View{
        Button(action: {
            shouldPresentAddCardForm.toggle()
        }, label: {
            Text("+ Card")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .background(Color.black)
                .cornerRadius(5)
        })
    }
    
    var addItemButton: some View {
        Button(action: {
            withAnimation {
                let viewContext = PersistenceController.shared.container.viewContext
                let card = Card(context: viewContext)
                card.timestamp = Date()

                do {
                    try viewContext.save()
                } catch {
                    
                }
            }
        }, label: {
            Text("Add Item")
        })
    }
    
    var deleteAllButton: some View {
        Button {
            cards.forEach { card in
                viewContext.delete(card)
            }
            
            do{
                try viewContext.save()
            } catch {
                
            }
           
        } label: {
            Text("Delete All")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView()
            .environment(\.managedObjectContext, viewContext)
    }
}
