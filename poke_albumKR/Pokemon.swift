//
//  Pokemon.swift
//  poke_albumKR
//
//  Created by Keith Russell on 5/11/16.
//  Copyright © 2016 Keith Russell. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _baseAttack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    //For MOVES segment - type/learn-typeCategory, Defense/MoveNameCategory
    // Height/PowerCategory PokedexId/Accuracy
    //Hide Weight and BaseAttack
    
    private var _moveDescription: String!
    private var _learnType: String!
    private var _moveName: String!
    private var _power: String!
    private var _accuracy: String!

    var moveDescription: String {
        if _moveDescription == nil {
            _moveDescription = ""
        }
        return _moveDescription
    }
    var learnType: String {
        if _learnType == nil {
            _learnType = ""
        }
        return _learnType
    }
    var moveName: String {
        if _moveName == nil {
            _moveName = ""
        }
        return _moveName
    }
    var power: String {
        if _power == nil {
            _power = ""
        }
        return _power
    }
    var accuracy: String {
        if _accuracy == nil {
            _accuracy = ""
        }
        return _accuracy
    }
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var  nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return  _nextEvolutionLvl
    }
    var pokemonUrl: String {
        if _pokemonUrl == nil {
            _pokemonUrl = ""
        }
        return _pokemonUrl
    }
    
    init(name: String, pokedexId: Int) {
        self._pokedexId = pokedexId
        self._name = name
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails (completed: DownloadComplete) {
        let url = NSURL (string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { Response in
            let result = Response.result
           
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                print("ID - NAME - WEIGHT - HEIGHT - BASEATTACK - DEFENSE")
                print(self.pokedexId)
                print(self._name)
                print(self._weight)
                print(self._height)
                print(self._baseAttack)
                print(self._defense)
                
                //MOVES
                
                if let moves = dict["moves"] as? [Dictionary<String, AnyObject>] where moves.count > 0 {
                    if let name = moves[0]["name"] {
                        self._moveName = name.capitalizedString
                        print("MOVES_COUNT")
                        print(moves.count)
                        
                        //For now only first move is provided to view - all data is available 
                        // to process additional moves but there are LOTS of them - often more than 50
                       
                    } else {
                        self._moveName = ""
                    }
                    if let learnType = moves[0]["learn_type"] {
                        self._learnType = learnType.capitalizedString
                    } else {
                        self._learnType = ""
                    }
                    // "resource_uri": "/api/v1/move/20/"
                    
                    if let url = moves[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { Response in
                            let desResult = Response.result
                            if let desDict = desResult.value as? Dictionary<String, AnyObject> {
                                if let description = desDict["description"] as? String {
                                    self._moveDescription = description
                                }
                                
                                if let pwr = desDict["power"] as? Int {
                                    self._power = "\(pwr)"
                                }
                                if let acc = desDict["accuracy"] as? Int {
                                    self._accuracy = "\(acc)"
                                }
                                print("MOVE_DETAILS")
                                print(self._moveDescription)
                                print(self.power)
                                print(self.accuracy)
                            }
                            completed()
                        }
                        
                    }
                }
                
                print("MOVES")
                print(self._moveName)
                print(self._learnType)
                //END MOVES
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
//                    else {
//                        self._type = ""
//                    }
                }
                    print("TYPES")
                    print(self._type)
                    
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] where descArr.count > 0  {
                        if let url = descArr[0]["resource_uri"] {
                            let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                            Alamofire.request(.GET, nsurl).responseJSON { Response in
                                let desResult = Response.result
                                if let desDict = desResult.value as? Dictionary<String, AnyObject> {
                                    if let description = desDict["description"] as? String {
                                        self._description = description
                                        print("DESCRIPTION")
                                        print(self._description)
                                    }
                                }
                            completed()
                        }
                        
                    } else {
                        self._description = ""
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        //cant suppot mega right now but
                        // app still has mega data
                        
                        if to.rangeOfString("mega") == nil {
                                    if let uri = evolutions[0]["resource_uri"] as? String {
                                        let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString:"")
                                        
                                        let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                        
                                        self._nextEvolutionId = num
                                        self._nextEvolutionTxt = to
                                        
                                        if let lvl = evolutions[0]["level"] as? Int {
                                                
                                            self._nextEvolutionLvl = "\(lvl)"
                                            } else {
                                                self._nextEvolutionLvl = ""
                                        }
                                        
                                        print("EVOLUTIONS HERE")
                                        print(self._nextEvolutionTxt)
                                        print(self._nextEvolutionId)
                                        print(self._nextEvolutionLvl)
                                    
                                    }
                                }
                            }
                }
            }
        }
    }
}