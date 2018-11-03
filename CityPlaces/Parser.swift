//
//  Parser.swift
//  CityPlaces
//
//  Created by vitali on 11/2/18.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import Foundation

protocol Parser {
    associatedtype Entity
    
    init(from data: Data)
    func parse() throws -> [Entity]
}
