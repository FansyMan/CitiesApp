//
//  ListService.swift
//  CitiesApp
//
//  Created by Surgeont on 29.11.2021.
//

import Foundation

    let city1 = City(name: "Тюмень", age: "3 век н.э")
    let city2 = City(name: "Вена", age: "1147 год")
    let city3 = City(name: "Казань", age: "1512 год")
    let city4 = City(name: "Махачкала", age: "1814 год")
    let city5 = City(name: "Берлин", age: "1237 год")
    let city6 = City(name: "Варшава", age: "1249 год")
    let city7 = City(name: "Милан", age: "1899 год")
    let city8 = City(name: "Архангельск", age: "1584 год")
    let city9 = City(name: "Москва", age: "1147 год")

class ListService {
    func getKists() -> [CityList] {
        return [
            CityList(color: "BE2813", shortName: "Русские", longName: "Русские", cities: [city1,city3,city4,city8,city9]),
            CityList(color: "F07F5A", shortName: "Старые", longName: "Старые", cities: [city2,city5,city6,city9]),
            CityList(color: "F3B53B", shortName: "Крутые", longName: "Крутые", cities: [city1,city3,city8,city9,city4]),
            CityList(color: "2D038F", shortName: "Большие", longName: "Большие", cities: [city9,city5]),
            CityList(color: "2D7FC1", shortName: "Длинные", longName: "Длинные", cities: [city9,city4,city1]),
            CityList(color: "1A4766", shortName: "Портовые", longName: "Портовые", cities: [city8,city5,city4]),
            ]
    }
}
