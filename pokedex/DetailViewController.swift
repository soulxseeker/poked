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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(pokemon.name)
        lblShowDetail.text = pokemon.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
