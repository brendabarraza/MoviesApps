import SwiftUI

struct ContentView: View {
    @State private var viewedMovies: [Result] = []
    @State private var showMoviesView = false
    
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    Home(viewedMovies: $viewedMovies)
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                NavigationView {
                    Buscar(viewedMovies: $viewedMovies)
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                
                NavigationView {
                    Perfil(viewedMovies: $viewedMovies)
                }
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }
            
            if showMoviesView {
                MoviesView(movie: "Película Seleccionada", viewedMovies: $viewedMovies)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                    }
            }
        }
        .onChange(of: showMoviesView) { newValue in
            if !newValue {
            }
        }
    }
}
