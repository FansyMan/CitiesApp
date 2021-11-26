//
//  CitiesService.swift
//  CitiesApp
//
//  Created by Surgeont on 25.11.2021.
//

import UIKit

class CitiesService {
    func getCities() -> [City] {
        return [
            City(name: "Moscow", age: "1147", picked: false),
            City(name: "Tumen", age: "12", picked: false),
            City(name: "Sochi", age: "123", picked: false),
            City(name: "Kazan", age: "432", picked: false),
            City(name: "Mahachkala", age: "542", picked: false),
            City(name: "Drezden", age: "123", picked: false),
            City(name: "Drezden", age: "123", picked: false),
            City(name: "Drezden", age: "123", picked: false),
            City(name: "Drezden", age: "123", picked: false),
            City(name: "Drezden", age: "123", picked: false)
        ]
    }
}
