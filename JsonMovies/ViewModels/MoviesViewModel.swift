


import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var currentMovie: Result?
    @Published var dataMovies: [Result] = []
    @Published var titulo = ""
    @Published var movieId = 0
    @Published var show = false
    @Published var key = ""

    func fetch(movie: String) async {
        do {
            let apiKey = " " //API
            let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(movie)&page=1&include_adult=false"
            
            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            
             
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }
            
            let json = try JSONDecoder().decode(Movies.self, from: data)
            self.dataMovies = json.results
            print(json.results)
        } catch {
            print("Error en la API: \(error.localizedDescription)")
        }
    }
    
    func fetchVideo() async {
        do {
            let apiKey = " " //API
            let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US"
            
            guard let url = URL(string: urlString) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }
            
            let json = try JSONDecoder().decode(VideoResponse.self, from: data)
            let res = json.results.filter { $0.type == "Trailer" }
            self.key = res.first?.key ?? ""
            
        } catch {
            print("Error en la API: \(error.localizedDescription)")
        }
    }
    
    func sendItem(item: Result) {
        titulo = item.original_title
        movieId = item.id
        show.toggle()
    }
}


