//
//  ContentView.swift
//  Desserts-Gallore-y
//
//  Created by Chellsea Carmel on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            DessertListView()
        }
    }
}

/// A custom cardview to display dessert information.
struct DessertListCardView: View{
    let meal:Meal
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                
                // Code to display dessert image in the card.
                if let imageUrl = meal.strMealThumb,
                    let url = URL(string: imageUrl) {
                    AsyncImage(url: url){
                        phase in
                        switch phase{
                        case .empty:
                            ProgressView().frame(idealHeight: 250)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                                .clipped()
                        case .failure:
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(.lightGray))
                                .frame(height: 250)
                                .clipped()
                        @unknown default:
                            EmptyView()
                        }
                        
                    }
                }
                // Code to display dessert name in the card.
                Text(meal.strMeal!).font(.title2)
                    .frame(width: 300)
                    .fontWeight(.semibold)
                                    .padding(6)
                                    .background(Color(.secondarySystemBackground).opacity(0.90))
                                    .cornerRadius(25)
                                    .padding([.bottom], 20)
            }
        }
            .cornerRadius(25)
            .shadow(radius: 5)
    }
}

/// A custom view to display a list of dessert card.
struct DessertListView: View {
    @State private var meals: [Meal] = []
    @State private var isDetailViewActive: Bool = false
    @State private var first: Bool = false
    var body: some View {
        
        VStack {
            NavigationView{
                List{
                    Text("Deserts Gallore-y")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity,alignment: .center)
                    
                    ForEach(meals){
                        meal in
                        // Display each dessert in its cardview.
                        DessertListCardView(meal: meal)
                            .background{
                                // Navigate to view containing detailed information of the selected desert.
                                NavigationLink(destination: DessertDetailView(meal: meal).onAppear {
                                    isDetailViewActive = true
                                    
                                }.onDisappear {
                                    isDetailViewActive = false
                                }) {
                                    EmptyView()
                                }
                            }
                            .listRowSeparator(.hidden)
                        
                    }
                }
                .listStyle(.plain)
                .onAppear{
                    Task{
                        await fetchDesserts()
                    }
                }
            }
        }
    }
    
    /// Asynchronous function to fetch all the available desserts and set the meals parameter of the view struct.
    func fetchDesserts() async {
        do {
            meals = try await MealService.shared.fetchDesserts()
        } catch {
            print("Error fetching meals: \(error)")

        }
    }
}

/// A custom view to display detailed dessert information.
struct DessertDetailView: View {
    let meal: Meal
    @State private var mealDetail: MealDetail?
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        ZStack(alignment: .bottom){
            
            // Display image of the desssert
            VStack{
                if let imageUrl = mealDetail?.strMealThumb,
                                let url = URL(string: imageUrl) {
                                AsyncImage(url: url){
                                    image in image.image?.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 358)
                                }
                                Spacer()
                            }
                else{
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 358)
                    Spacer()
                }
            }.overlay(alignment: .center){
                if let name = mealDetail?.strMeal{
                    Text(name).font(.title)
                        .frame(width: UIScreen.main.bounds.width-10, height: 100)
                                        .padding(6)
                                        .background(Color(.secondarySystemBackground).opacity(1))
                                        .cornerRadius(20)
                                        .padding([.bottom], 60)
                                        .bold()
                                        .shadow(radius: 35)
                }
                else{
                    Text("Name Unknown").font(.title2)
                        .frame(width: UIScreen.main.bounds.width-13, height: 100)
                                        .padding(6)
                                        .background(Color(.secondarySystemBackground).opacity(1))
                                        .cornerRadius(35)
                                        .padding([.bottom], 20)
                                        .bold()
                }
            }
            VStack{
                HStack{
                    
                    Spacer()
                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color(.black).opacity(0.65))
                                    .shadow(radius: 30)
                            )
                    }
                }
                .padding(.top)
                .padding()
                .padding()
            
                Spacer()
                
                RecipieView(meal:meal,mealDetail: mealDetail)
            }
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                       Task {
                           await fetchDessertDetail()
                       }
                   }
    }
    /// Asynchronous function to fetch the selected dessert's  detailed information and set the mealDetail parameter of the view struct.
    func fetchDessertDetail() async {
           do {
               mealDetail = try await MealService.shared.fetchDessertDetail(by: meal.idMeal)
           } catch {
               print("Error fetching meal detail: \(error)")
           }
    }
}

/// A custom view to display recipie related information such as ingredients, instructions etc
struct RecipieView: View {
    @State private var selectedTab: String = "ingredients"
    let meal: Meal
    var mealDetail: MealDetail?
    
    var body: some View{
        
        ZStack(alignment: .top){
            
            Rectangle()
                .fill(Color(.secondarySystemBackground))
                .frame(height: UIScreen.main.bounds.height * 0.48)
    
            
            // Buttons to allow user to view ingredient and recipie instructions
            VStack{
                HStack{
                    Button{
                        self.selectedTab = "ingredients"
                    }label:{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(selectedTab=="ingredients" ? Color(.systemBlue) : Color(.clear))
                            .frame(width: (UIScreen.main.bounds.width/2)-20,height:50)
                            .shadow(radius: 5)
                            .overlay{
                                
                                HStack {
                                    Text("🥕")
                                    Text("Ingredients")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(selectedTab=="ingredients" ? Color(.white) : Color.primary.opacity(0.75))
                                }
                            }
                    }
                    Button{
                        self.selectedTab = "instructions"
                    }label:{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(selectedTab=="instructions" ? Color(.systemBlue) : Color(.clear))
                            .frame(width: (UIScreen.main.bounds.width/2)-20,height:50)
                            .shadow(radius: 5)
                            .overlay{
                                HStack {
                                    Text("📝")
                                    Text("Instructions")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(selectedTab=="instructions" ? Color(.white) : Color.primary.opacity(0.75))
                                }
                            }
                        }
                }.background{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.clear))
                    
                }
                
                // Based on the selected button display ingredients and instructions
                if(selectedTab=="ingredients"){
                    ScrollView{
                        VStack{
                            if (mealDetail?.ingredients) != nil{
                                ForEach(mealDetail!.ingredients, id: \.0) {
                                    ingredient, measure in
                                    HStack {
                                        Text("\(ingredient): \(measure)")
                                        Spacer()
                                    }.frame(maxWidth: .infinity)
                                        .padding([.bottom,.leading,.trailing], 8.0)
                                }
                            }
                            else{
                                Text("Details not available")
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height*0.40)
                        .edgesIgnoringSafeArea(.bottom)
                }
                else{
                    ScrollView{
                        VStack(alignment:.leading){
                            if (mealDetail?.strInstructions) != nil{
                                Text(mealDetail!.strInstructions)
                                    .frame(maxWidth: .infinity)
                                    .padding([.bottom,.leading,.trailing], 8.0)
                                Spacer()
                            }
                            
                            else{
                                Text("Instructions Not Available")
                                    .frame(maxWidth: .infinity)
                                        .padding()
                                Spacer()
                            }
                            
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height*0.40)
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
