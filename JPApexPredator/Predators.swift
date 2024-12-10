//
//  Predator.swift
//  JPApexPredator
//
//  Created by Lorusso, Michele on 10/12/24.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredatorModel] = []
    var filteredPredators: [ApexPredatorModel] = []

    init() {
        decodeData()
    }

    func decodeData() {
        if let url = Bundle.main.url(
            forResource: "jpapexpredators", withExtension: "json")
        {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apexPredators = try decoder.decode(
                    [ApexPredatorModel].self, from: data)
                self.apexPredators = apexPredators
                self.filteredPredators = apexPredators
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

    func filter(for searchText: String) -> [ApexPredatorModel] {
        return filteredPredators.filter {
            searchText.isEmpty || $0.name.contains(searchText)
        }
    }

    func filter(for predatorType: PredatorType) {
        filteredPredators = apexPredators.filter { predator in predator.type == predatorType || predatorType == .all
        }
    }

    func sort(by alphabetical: Bool) {
        apexPredators.sort { alphabetical ? $0.name < $1.name : $0.id < $1.id }
    }
}
