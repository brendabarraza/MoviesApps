import SwiftUI

struct BestReviews: View {
    var movie: String
    @Binding var viewedMovies: [Result]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showMovieDetail = false
    @State private var selectedMovie: Result?
    
    let movies: [Result] = [
        Result(id: 1, original_title: "Superbad", poster_path: "/ek8e8txUyUwd2BNqj6lFEerJfbq.jpg", overview: "Una comedia sobre dos amigos que intentan conseguir alcohol para una fiesta antes de graduarse."),
        Result(id: 2, original_title: "Anchorman", poster_path: "/9rQceSyOxJpOVsJRhkgoxNqbkvA.jpg", overview: "La historia del extravagante presentador de noticias de los 70, Ron Burgundy."),
        Result(id: 3, original_title: "Step Brothers", poster_path: "/wRR6U3K3v2iQsG3uw7ehz1ctRyT.jpg", overview: "Dos adultos que se vuelven hermanastros tienen problemas para adaptarse a la vida juntos."),
        Result(id: 4, original_title: "The Hangover", poster_path: "/uluhlXubGu1VxU63X9VHCLWDAYP.jpg", overview: "Un grupo de amigos despierta tras una alocada despedida de soltero en Las Vegas sin recordar nada."),
        Result(id: 5, original_title: "21 Jump Street", poster_path: "/8v3Sqv9UcIUC4ebmpKWROqPBINZ.jpg", overview: "Dos policías jóvenes son asignados a una misión encubierta en una escuela secundaria."),
        Result(id: 6, original_title: "Dumb and Dumber", poster_path: "/4LdpBXiCyGKkR8FGHgjKlphrfUc.jpg", overview: "Dos amigos extremadamente tontos se embarcan en un viaje por carretera para devolver una maleta."),
        Result(id: 7, original_title: "Shaun of the Dead", poster_path: "/dgXPhzNJH8HFTBjXPB177yNx6RI.jpg", overview: "Un hombre intenta reconquistar a su novia en medio de un apocalipsis zombi."),
        Result(id: 8, original_title: "Zoolander", poster_path: "/qdrbSneHZjJG2Dj0hhBxzzAo4HB.jpg", overview: "Un modelo tonto es reclutado en una trama para asesinar al primer ministro de Malasia."),
        Result(id: 9, original_title: "Bridesmaids", poster_path: "/gJtA7hYsBMQ7EM3sPBMUdBfU7a0.jpg", overview: "Una comedia sobre los altibajos de ser la dama de honor en la boda de tu mejor amiga."),
        Result(id: 10, original_title: "Tropic Thunder", poster_path: "/zAurB9mNxfYRoVrVjAJJwGV3sPg.jpg", overview: "Un grupo de actores en una película de guerra termina viviendo una verdadera guerra en la jungla."),
        Result(id: 11, original_title: "Ferris Bueller's Day Off", poster_path: "/9LTQNCvoLsKXP0LtaKAaYVtRaQL.jpg", overview: "Un adolescente planea un día perfecto saltándose la escuela y explorando Chicago."),
        Result(id: 12, original_title: "The 40-Year-Old Virgin", poster_path: "/mVeoqL37gzhMXQVpONi9DGOQ3tZ.jpg", overview: "Un hombre virgen de 40 años es convencido por sus amigos de buscar una relación."),
        Result(id: 13, original_title: "Hot Fuzz", poster_path: "/zPib4ukTSdXvHP9pxGkFCe34f3y.jpg", overview: "Un superpolicía es enviado a un tranquilo pueblo inglés donde ocurren crímenes sospechosos."),
        Result(id: 14, original_title: "School of Rock", poster_path: "/zXLXaepIBvFVLU25DH3wv4IPSbe.jpg", overview: "Un músico desempleado se hace pasar por maestro y convierte a sus estudiantes en una banda de rock."),
        Result(id: 15, original_title: "Ace Ventura", poster_path: "/yaHnZqJvsSddOKYxf4zCj2Ww2hA.jpg", overview: "Un detective de mascotas excéntrico es contratado para encontrar la mascota perdida de un equipo deportivo.")
    ]

    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(movies) { movie in
                        Button(action: {
                            selectedMovie = movie
                            showMovieDetail.toggle()
                        }) {
                            VStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(movie.poster_path ?? "")")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(10)
                                } placeholder: {
                                    Image("no_poster")
                                        .resizable()
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(10)
                                }
                                Text(movie.original_title)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 120)
                            }
                        }
                    }
                }
                .padding(20)
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
        .sheet(isPresented: $showMovieDetail) {
            if let movie = selectedMovie {
                MoviesView(movie: movie.original_title, viewedMovies: $viewedMovies)
            }
        }
    }
    
    private func addToViewedMovies(_ movie: Result) {
        if !viewedMovies.contains(where: { $0.id == movie.id }) {
            viewedMovies.append(movie)
        }
    }
}
