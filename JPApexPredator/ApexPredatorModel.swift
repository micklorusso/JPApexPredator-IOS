//
//  ApexPredatorModel.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import SwiftUICore

class ApexPredatorModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum PredatorType: String, Decodable {
        case land
        case sea
        case air
        
        var color: Color {
            switch self {
            case .land: return Color.brown
            case .sea: return Color.blue
            case .air: return Color.teal
            }
        }
    }
}
