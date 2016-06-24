//
//  pokemon.swift
//  pokedex
//
//  Created by Soulxsense on 6/21/2559 BE.
//  Copyright © 2559 Soulxsense. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}
