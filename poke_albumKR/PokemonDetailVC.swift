//
//  PokemonDetailVC.swift
//  poke_albumKR
//
//  Created by Keith Russell on 5/12/16.
//  Copyright © 2016 Keith Russell. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var evolution1Img: UIImageView!
    @IBOutlet weak var evolution2Img: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        evolution1Img.image = img
        
        pokemon.downloadPokemonDetails { 
            //this will be called after download is done
            self.updateUI()
        }
        
    }

    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        pokedexLbl.text = "\(pokemon.pokedexId)"
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.baseAttack
        if pokemon.nextEvolutionId == "" {
            evolutionLbl.text = "No Evolutions"
            evolution2Img.hidden = true
        } else {
            evolution2Img.hidden = false
            evolution2Img.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                print("EVOLVL")
                print(pokemon.nextEvolutionLvl)
                print(str)
            }
           evolutionLbl.text = str
        }
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
