//
//  PokemonDetailVC.swift
//  poke_albumKR
//
//  Created by Keith Russell on 5/12/16.
//  Copyright © 2016 Keith Russell. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeAndLearnTypeLbl: UILabel!
    @IBOutlet weak var defenseAndMoveNameLbl: UILabel!
    @IBOutlet weak var heightAndPowerLbl: UILabel!
    @IBOutlet weak var pokedexAndAccuracyLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var evolution1Img: UIImageView!
    @IBOutlet weak var evolution2Img: UIImageView!
    
    //Extra outlets for MOVES - type/learn-typeCategory, Defense/MoveNameCategory
    // Height/PowerCategory PokedexId/Accuracy
    //Hide Weight and BaseAttack
    @IBOutlet weak var typeAndLearnTypeCategory: UILabel!
    @IBOutlet weak var defenseAndMoveNameCategory: UILabel!
    @IBOutlet weak var heightAndPowerCategory: UILabel!
    @IBOutlet weak var pokedexidAndAccuracyCategory: UILabel!
    @IBOutlet weak var weightCategory: UILabel!
    @IBOutlet weak var baseAttackCategory: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialBioDataLoad()

    }
    
    func initialBioDataLoad () {
        weightLbl.hidden = false
        baseAttackLbl.hidden = false
        weightCategory.hidden = false
        baseAttackCategory.hidden = false
        nameLbl.text = pokemon.name.capitalizedString
        typeAndLearnTypeCategory.text = "Type:"
        defenseAndMoveNameCategory.text = "Defense:"
        heightAndPowerCategory.text = "Height:"
        pokedexidAndAccuracyCategory.text = "PokedexId:"
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        evolution1Img.image = img
        
        pokemon.downloadPokemonDetails {
            //this will be called after download is done
            self.updateUI()
        }
    }
    
    func movesDataLoad() {
        nameLbl.text = pokemon.name.capitalizedString
        typeAndLearnTypeCategory.text = "Learn-type:"
        defenseAndMoveNameCategory.text = "Move Name:"
        heightAndPowerCategory.text = "Power:"
        pokedexidAndAccuracyCategory.text = "Accuracy:"
        weightLbl.hidden = true
        baseAttackLbl.hidden = true
        weightCategory.hidden = true
        baseAttackCategory.hidden = true
    }

    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeAndLearnTypeLbl.text = pokemon.type
        defenseAndMoveNameLbl.text = pokemon.defense
        pokedexAndAccuracyLbl.text = "\(pokemon.pokedexId)"
        heightAndPowerLbl.text = pokemon.height
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
    @IBAction func segmentPressed(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            initialBioDataLoad()
        case 1:
            nameLbl.text = "Second"
            movesDataLoad()
        default:
            break; 
        }
        }
}
