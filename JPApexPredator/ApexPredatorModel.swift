//
//  ApexPredatorModel.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import SwiftUICore
import MapKit

class ApexPredatorModel: Decodable, Identifiable, Equatable {
    static let movies = [
        "All Movies",
        "Jurassic Park",
        "The Lost World: Jurassic Park",
        "Jurassic Park III",
        "Jurassic World",
        "Jurassic World: Fallen Kingdom",
        "Jurassic World: Dominion"
    ]
    
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String

    static func == (lhs: ApexPredatorModel, rhs: ApexPredatorModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }

}

enum PredatorType: String, Decodable, Identifiable, CaseIterable {
    case all
    case land
    case sea
    case air

    var id: PredatorType { self }

    var color: Color {
        switch self {
        case .land: return Color.brown
        case .sea: return Color.blue
        case .air: return Color.teal
        case .all: return Color.black
        }
    }
    
    var icon: String {
        switch self {
        case .land: return "leaf.fill"
        case .sea: return "drop.fill"
        case .air: return "wind"
        case .all: return "square.stack.3d.up.fill"
        }
    }
}
