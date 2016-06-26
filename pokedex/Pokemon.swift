//
//  pokemon.swift
//  pokedex
//
//  Created by Soulxsense on 6/21/2559 BE.
//  Copyright © 2559 Soulxsense. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name: String!
    private var _pokedexId: Int!
    
    private var _description: String!
    private var _type: String!
    private var _deferance: String!
    private var _hight: String!
    private var _width: String!
    private var _baseExp: String!
    private var _nextEvalutionTxt: String!
    private var _pokemonURL: String!

    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var width: String{
        get{
            if _width == nil {
                return ""
            }
            return _width

        }
    }
    
    var hight: String{
        get{
            if _hight == nil {
                return ""
            }
            return _hight
        }
    }
    
    var baseExp: String{
        get{
            if _baseExp == nil {
                return ""
            }
            return _baseExp
        }
    }
    
    var type: String{
        get{
            if _type == nil {
                return ""
            }
            return _type
        }
    }
    
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetail(competed: DownloadCompete){
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary <String,AnyObject> {

                if let width = dict["weight"] as? Int {
                    self._width = "\(width)"
                }
                
                if let height = dict["height"] as? Int {
                    self._hight = "\(height)"
                }
                
                if let baseExp = dict["base_experience"] as? Int {
                    self._baseExp = "\(baseExp)"
                }
                
                if let typesArr = dict["types"] as? [Dictionary<String,AnyObject>] where typesArr.count > 0 {
                    if let type = typesArr[0]["type"] as? Dictionary<String,AnyObject> {
                        if let name = type["name"] as? String {
                            self._type = name
                        }
                    }
                }
                
                competed()
        
            }
        }
    }
}
