//
//  DetailViewController.swift
//  pokedex
//
//  Created by Soulxsense on 6/24/2559 BE.
//  Copyright © 2559 Soulxsense. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemon: Pokemon!
    @IBOutlet weak var lblShowDetail: UILabel!
    @IBOutlet weak var imgcurLv: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTyep: UILabel!
    @IBOutlet weak var lblDeferance: UILabel!
    @IBOutlet weak var lblHight: UILabel!
    @IBOutlet weak var lblWidth: UILabel!
    @IBOutlet weak var lblAttack: UILabel!
    @IBOutlet weak var lblPokeId: UILabel!
    @IBOutlet weak var lblDesctionLv: UILabel!
    @IBOutlet weak var imgCurEvalution: UIImageView!
    @IBOutlet weak var imgNextEvalution: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblShowDetail.text = pokemon.name
        imgcurLv.image = UIImage(named: "\(pokemon.pokedexId)")
        imgCurEvalution.image = UIImage(named: "\(pokemon.pokedexId+1)")
        imgNextEvalution.image = UIImage(named: "\(pokemon.pokedexId+2)")
        
        pokemon.downloadPokemonDetail { () -> () in
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        lblHight.text = pokemon.hight
        lblWidth.text = pokemon.width
        lblDeferance.text = pokemon.baseExp
        lblTyep.text = pokemon.type
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(sender: AnyObject) {
           dismissViewControllerAnimated(true, completion: nil)
    }
    
    //test ssh

}
