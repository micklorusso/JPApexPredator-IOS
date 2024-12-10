//
//  PredatorDetail.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredatorModel
    @State var cameraPosition: MapCameraPosition
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay(){
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.3)
                        .offset(y: 20)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 10)
                }
                
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                        .bold()
                    
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80)))
                    } label: {
                        Map(position: $cameraPosition) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse").font(.largeTitle)
                                    .symbolEffect(.pulse)
                            }.annotationTitles(.hidden)
                        }
                        .frame(height: 150)
                        .overlay(alignment: .topLeading){
                            Text("Current Location")
                                .padding(5)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .font(.title)
                                .padding(.trailing, 5)
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }.toolbarBackground(.automatic)
                   
                    
                    Text("Appears in:")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• \(movie)").padding(.top)
                    }
                    
                    Text("Movie Moments")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    ForEach(predator.movieScenes) { movieScene in
                        Text(movieScene.movie)
                            .font(.title3).padding(.vertical, 5)
                        Text(movieScene.sceneDescription)
                            .padding(.bottom)
                    }
                    
                    Text("Read More:")
                    Link(predator.link, destination: URL(string: predator.link)!).foregroundStyle(.blue)
                        .font(.caption)
                    
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    let predators = Predators()
    let number = 10
    NavigationStack {
        PredatorDetail(predator: predators.apexPredators[number], cameraPosition: .camera(MapCamera(centerCoordinate: predators.apexPredators[number].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
