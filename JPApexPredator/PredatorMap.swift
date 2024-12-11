//
//  PredatorMap.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var position: MapCameraPosition
    @State var satellite: Bool = false
    @State private var selectedPredator: ApexPredatorModel? = nil
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(predators.apexPredators) {
                    predator in
                    Annotation(predator.name, coordinate: predator.location) {
                        Button {
                            selectedPredator = predator
                        } label: {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .shadow(color: .white, radius: 5)
                                .scaleEffect(x: -1)
                        }
                    }
                }
            }
            .toolbarBackground(.automatic)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    satellite.toggle()
                } label: {
                    Image(systemName: satellite ? "globe.americas.fill" : "globe.americas").font(.largeTitle)
                        .imageScale(.large)
                        .background(.thinMaterial)
                        .padding()
                    
                }
            }
            .mapStyle(satellite ? MapStyle.imagery(elevation: .realistic) : MapStyle.standard(elevation: .realistic))
            
            if let predator = selectedPredator {
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(predator.name)
                            .font(.headline)
                        Text("Location: \(predator.location.latitude), \(predator.location.longitude)")
                            .font(.subheadline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    .onTapGesture {
                        selectedPredator = nil
                    }
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: selectedPredator)
            }
        }
    }
}

#Preview {
    PredatorMap(position:.camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}
