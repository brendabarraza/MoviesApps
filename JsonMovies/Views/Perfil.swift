import SwiftUI

struct Perfil: View {
    @Binding var viewedMovies: [Result]

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewedMovies, id: \.id) { movie in
                    HStack(alignment: .top) {
                        if let posterUrl = movie.poster_path,
                           let url = URL(string: "https://image.tmdb.org/t/p/w200/\(posterUrl)") {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(10)
                            } placeholder: {
                                Image("no_poster")
                                    .resizable()
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(10)
                            }
                        } else {
                            Image("no_poster")
                                .resizable()
                                .frame(width: 80, height: 120)
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.original_title)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(movie.overview)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(3)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                .onDelete(perform: deleteMovie)
            }
            .navigationTitle("Seen movies")
        }
    }
    
    private func deleteMovie(at offsets: IndexSet) {
        viewedMovies.remove(atOffsets: offsets)
    }
}
