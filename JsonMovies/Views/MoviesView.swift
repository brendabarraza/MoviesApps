import SwiftUI

struct MoviesView: View {
    
    var movie: String
    @StateObject var movies = MoviesViewModel()
    @Binding var viewedMovies: [Result]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            List {
                ForEach(movies.dataMovies) { item in
                    HStack {
                        CardView(poster: item.poster_path ?? "", title: item.original_title, overview: item.overview, action: {
                            movies.sendItem(item: item)
                        }, addToViewedMoviesAction: {
                            addToViewedMovies(item)
                        })
                    }
                    .sheet(isPresented: $movies.show) {
                        TrailerView(movies: movies)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
        .navigationTitle(movie)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
        .task {
            await movies.fetch(movie: movie)
        }
    }
    
    private func addToViewedMovies(_ movie: Result) {
        print("Agregando película: \(movie.original_title)")
        
        if !viewedMovies.contains(where: { $0.id == movie.id }) {
            viewedMovies.append(movie)
        }
    }
}
