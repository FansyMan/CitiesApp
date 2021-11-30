//
//  ListService.swift
//  CitiesApp
//
//  Created by Surgeont on 29.11.2021.
//

import Foundation

let city1 = City(name: "Moscow", age: "1147", picked: false)
let city2 = City(name: "Tumen", age: "12", picked: false)
let city3 = City(name: "Sochi", age: "123", picked: false)
let city4 = City(name: "Kazan", age: "432", picked: false)
let city5 = City(name: "Mahachkala", age: "542", picked: false)
let city6 = City(name: "Drezden", age: "123", picked: false)
let city7 = City(name: "Drezden", age: "123", picked: false)
let city8 = City(name: "Drezden", age: "123", picked: false)
let city9 = City(name: "Drezden", age: "123", picked: false)
let city10 = City(name: "Drezden", age: "123", picked: false)

class ListService {
    func getKists() -> [CityList] {
        return [
            CityList(color: "F07F5A", shortName: "", longName: "", cities: [city1, city2]),
            CityList(color: "2D7FC1", shortName: "", longName: "", cities: [city3, city4, city5]),
            CityList(color: "BE2813", shortName: "", longName: "", cities: [city5, city6, city7, city8, city9, city10]),
            CityList(color: "F07F5A", shortName: "", longName: "", cities: [city5, city6, city7, city8, city9, city10]),
            CityList(color: "2D7FC1", shortName: "", longName: "", cities: [city5, city6, city7, city8, city9, city10]),
            CityList(color: "BE2813", shortName: "", longName: "", cities: [city5, city6, city7, city8, city9, city10])
            ]
    }
}
