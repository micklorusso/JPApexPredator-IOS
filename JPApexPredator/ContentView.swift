//
//  ContentView.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    var body: some View {
        List(predators.apexPredators) {
            predator in
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
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
