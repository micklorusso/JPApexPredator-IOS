//
//  Predator.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredatorModel] = []
    
    init(){
        decodeData()
    }
    
    func decodeData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apexPredators = try decoder.decode([ApexPredatorModel].self, from: data)
                self.apexPredators = apexPredators
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
