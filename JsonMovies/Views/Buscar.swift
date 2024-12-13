

import SwiftUI

struct Buscar: View {
    @Binding var viewedMovies: [Result]
    @State private var search = ""
    @State private var buscar = false
    @State private var allMovies = ["Batman", "Barbie", "Back to the Future", "Bad Boys", "Bad Boys for Life", "Basic Instinct", "Babe", "Babel", "Bad Santa", "Avatar", "Inception", "Iron Man", "The Dark Knight", "Titanic"]
    @State private var filteredMovies: [String] = []
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    if !search.isEmpty {
                        Button {
                            search = ""
                            UIApplication.shared.endEditing()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        .padding(.leading, 10)
                    }
                    
                    TextField("Search", text: $search)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading, 10)
                        .onChange(of: search) { newValue in
                            if newValue.isEmpty {
                                filteredMovies = []
                            } else {
                                filteredMovies = allMovies.filter { $0.lowercased().contains(newValue.lowercased()) }
                            }
                        }
                    
                    Button {
                        buscar.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.bordered)
                    .tint(.black)
                    .padding(.trailing, 10)
                }
                .padding(.bottom, 10)
                
                if !filteredMovies.isEmpty && !search.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(filteredMovies, id: \.self) { movie in
                                Text(movie)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.black.opacity(0.6))
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        search = movie
                                        filteredMovies = []
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                    }
                    .frame(maxHeight: 300)
                }
                
                Spacer()
            }
            .padding(.all)
            .navigationBarHidden(true)
            
            .sheet(isPresented: $buscar) {
                MoviesView(movie: search, viewedMovies: $viewedMovies)
            }
        }
        .environment(\.colorScheme, .light)
    }
}

extension UIApplication {
    func endEditing() {
        windows.filter { $0.isKeyWindow }.first?.endEditing(true)
    }
}


