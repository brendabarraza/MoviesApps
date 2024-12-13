import SwiftUI

struct Home: View {
    @Binding var viewedMovies: [Result]
    @State private var showMovieView = false
    @State private var selectedMovie: String? = nil
    @State private var showBestReviews = false

    // Diccionario con las categorías y sus películas
    let movieCategories: [String: [Result]] = [
        "The latest": [
            Result(id: 1, original_title: "Joker: Folie à Deux", poster_path: "/if8QiqCI7WAGImKcJCfzp6VTyKA.jpg" , overview: "Descripcion de Joker"),
            Result(id: 2, original_title: "Barbie", poster_path: "/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg", overview: "Descripcion de Barbie"),
            Result(id: 3, original_title: "It Ends With Us", poster_path: "/AjV6jFJ2YFIluYo4GQf13AA1tqu.jpg", overview: "Descripcion de It Ends With Us")
        ],
        "Classics": [
            Result(id: 4, original_title: "The Dark Knight", poster_path: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg", overview: "Descripcion de Batman"),
            Result(id: 5, original_title: "Back to the Future", poster_path: "/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg", overview: "Descripcion de Back to the Future"),
            Result(id: 6, original_title: "Titanic", poster_path: "/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", overview: "Descripcion de Titanic")
        ],
        "Best reviews": [
            Result(id: 7, original_title: "Avatar", poster_path: "/kyeqWdyUXW608qlYkRqosgbbJyK.jpg", overview: "Descripcion de Avatar"),
            Result(id: 8, original_title: "Citizen Kane", poster_path: "/sav0jxhqiH0bPr2vZFU0Kjt2nZL.jpg", overview: "Descripcion de Avatar"),
            Result(id: 9, original_title: "Inception", poster_path: "/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg", overview: "Descripcion de Inception"),
            Result(id: 10, original_title: "Gladiator", poster_path: "/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg", overview: "Descripcion de Iron Man")
        ],
        "Comedy": [
            Result(id: 11, original_title: "Skrek", poster_path: "/iB64vpL3dIObOtMZgX3RqdVdQDc.jpg", overview: "Descripcion de Proyecto X"),
            Result(id: 12, original_title: "21 jump street", poster_path: "/8v3Sqv9UcIUC4ebmpKWROqPBINZ.jpg", overview: "Descripcion de Comando Especial"),
            Result(id: 13, original_title: "mean girls", poster_path: "/fXm3YKXAEjx7d2tIWDg9TfRZtsU.jpg", overview: "Descripcion de La Máscara"),
            Result(id: 14, original_title: "Proyecto X", poster_path: "/lUPDGT3lyRrq8SvWuNWG2DP64bR.jpg", overview: "Descripcion de Proyecto X"),
            Result(id: 15, original_title: "", poster_path: "more.png", overview: "Descripcion de It Ends With Us")
        ]
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(movieCategories.keys.sorted(), id: \.self) { category in
                        Text(category)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white) 
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(movieCategories[category] ?? []) { movie in
                                    Button(action: {
                                        if movie.id == 15 {
                                            showBestReviews.toggle()
                                        } else {
                                            selectedMovie = movie.original_title
                                            showMovieView.toggle()
                                        }
                                    }) {
                                        MovieCardView(movie: movie)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .frame(height: 250)
                    }
                }
            }
            .background(Color.black)
            .navigationTitle("Movie Searcher")
                .foregroundColor(.white)
            .foregroundColor(.white)
            .sheet(isPresented: $showMovieView) {
                if let selectedMovie = selectedMovie {
                    MoviesView(movie: selectedMovie, viewedMovies: $viewedMovies)
                }
            }
            .sheet(isPresented: $showBestReviews) {
                BestReviews(movie: selectedMovie ?? "Película desconocida", viewedMovies: $viewedMovies)
            }
        }
    }
}

struct MovieCardView: View {
    let movie: Result
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(movie.poster_path ?? "")")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
            } placeholder: {
                Image("no_poster") // Imagen de marcador si no se encuentra el póster
                    .resizable()
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
            }
            Text(movie.original_title)
                .font(.caption)
                .foregroundColor(.white) // Texto en blanco
                .frame(maxWidth: 120)
                .multilineTextAlignment(.center)
        }
    }
}

