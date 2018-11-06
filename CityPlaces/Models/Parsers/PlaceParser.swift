//
//  PlaceParser.swift
//  CityPlaces
//
//  Created by vitali on 11/1/18.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import Foundation


enum ParsingError: Error {
    case multivalueParsingError(String)
    case invalidJsonStructure(String)
}


fileprivate struct PlacesJson: Decodable {
    let data: [PlaceData]
}
fileprivate enum Multivalue: Decodable {
    
    enum DecodeError: Error {
        case unknownType
    }
    
    case real(Double)
    case string(String)
    case bool(Bool)
    case null
    indirect case multivalueArray([Multivalue])
    
    init(from decoder: Decoder) throws {
        if let bool = try? decoder.singleValueContainer().decode(Bool.self){
            self = .bool(bool)
            return
        }
        if let real = try? decoder.singleValueContainer().decode(Double.self){
            self = .real(real)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self){
            
            if let real = Double(string){
                self = .real(real)
            } else {
                self = .string(string)
            }
            return
        }
        if let multivalue = try? decoder.singleValueContainer().decode([Multivalue].self){
            self = .multivalueArray(multivalue)
            return
        }
        if let _ = try? decoder.singleValueContainer().decodeNil(){
            self = .null
            return
        }
        throw DecodeError.unknownType
    }
}

fileprivate struct PlaceData: Decodable {
    
    struct Const {
        static let latitudeIndex = 18
        static let longtitudeIndex = 19
        static let nameIndex = 15
        static let descriptionIndex = 11
    }
    
    var place: Place
    
    init(from decoder: Decoder) throws {
        guard let propertyArray = try? decoder.singleValueContainer().decode([Multivalue].self) else {
            throw ParsingError.invalidJsonStructure("Property array is nil")
        }
        let lat: Double = try {
            let index = Const.latitudeIndex
            switch propertyArray[index]{
            case .real(let value):
                return value
            default:
                throw ParsingError.multivalueParsingError(
                    "Error when parsing latitude. Not Real value at index \(index)"
                )
            }
            }()
        let lon: Double = try {
            let index = Const.longtitudeIndex
            switch propertyArray[index]{
            case .real(let value):
                return value
            default:
                throw ParsingError.multivalueParsingError(
                    "Error when parsing longtitude. Not Real value at index \(index)"
                )
            }
            }()
        let name: String = try {
            let index = Const.nameIndex
            switch propertyArray[index] {
            case .string(let name):
                return name
            default:
                throw ParsingError.multivalueParsingError(
                    "Error when parsing name. Not Real value at index \(index)"
                )
            }
            }()
        let description: String? = try {
            let index = Const.descriptionIndex
            switch propertyArray[index] {
            case .string(let name):
                return name
            case .null:
                return nil
            default:
                throw ParsingError.multivalueParsingError(
                    "Error when parsing description. Not String value at index \(index)"
                )
            }
            }()
        place = Place(lon: lon, lat: lat, name: name, locationName: description)
    }
}



//MARK: - PlaceParser
class PlaceParser: Parser {
    typealias Entity = Place
    
    private var data: Data
    private var decoder = JSONDecoder()
    
    
    required init(from data: Data) {
        self.data = data
    }
    
    func parse() throws -> [Place] {
        
        let plaseJson = try decoder.decode(PlacesJson.self, from: self.data)
        let places = plaseJson.data.map({$0.place })
        return places
    }
}






