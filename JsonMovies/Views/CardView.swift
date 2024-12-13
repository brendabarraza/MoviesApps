

import SwiftUI

struct CardView: View {
    
    var poster: String
    var title: String
    var overview: String
    var action: () -> Void
    var addToViewedMoviesAction: () -> Void
    
    @State private var showAddToViewedAlert = false
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(poster)")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 5)
                } placeholder: {
                    Image("no_poster")
                }
            }
            
            Text(title)
                .font(.title)
                .padding(.top, 8)
            Text(overview)
                .foregroundColor(.gray)
                .lineLimit(3)
                .padding(.top, 4)
        }
        .padding(.all)
        .onTapGesture {
            action()
        }
        .onLongPressGesture {
            showAddToViewedAlert.toggle()
        }
        .alert(isPresented: $showAddToViewedAlert) {
            Alert(
                title: Text("Add to Seen movies"),
                message: Text("Do you want to add this movie to your watched list?"),
                primaryButton: .default(Text("Add")) {
                    addToViewedMoviesAction()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
