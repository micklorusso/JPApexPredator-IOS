//
//  ContentView.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    
    @State var alphabetical: Bool = false
    
    @State var predatorType: PredatorType = .all
    
    var filteredList: [ApexPredatorModel] {
        predators.sort(by: alphabetical)
        predators.filter(for: predatorType)
        return predators.filter(for: searchText)
    }

    var body: some View {
        NavigationStack {
            List(filteredList) {
                predator in
                NavigationLink {
                    PredatorDetail(predator: predator, cameraPosition: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue).fontWeight(.light)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(predator.type.color)
                                .clipShape(Capsule())

                        }
                    }
                }
            }.searchable(text: $searchText)
                .animation(.default, value: searchText)
                .autocorrectionDisabled()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.default) {
                                alphabetical.toggle()
                            }
                        } label: {
                            Image(systemName: alphabetical ? "film" : "textformat").symbolEffect(.bounce, value: alphabetical)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter", selection: $predatorType) {
                                ForEach(PredatorType.allCases) { predatorType in
                                    Label(predatorType.rawValue, systemImage: predatorType.icon)
                                }
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                }
        }.preferredColorScheme(.dark)
            
    }
}

#Preview {
    ContentView()
}
