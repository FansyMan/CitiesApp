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
            City(name: "Тюмень", age: "3 век н.э"),
            City(name: "Вена", age: "1147 год"),
            City(name: "Казань", age: "1512 год"),
            City(name: "Махачкала", age: "1814 год"),
            City(name: "Берлин", age: "1237 год"),
            City(name: "Варшава", age: "1249 год"),
            City(name: "Милан", age: "1899 год"),
            City(name: "Архангельск", age: "1584 год"),
            City(name: "Москва", age: "1147 год")
        ]
    }
}
