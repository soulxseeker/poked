//
//  ViewController.swift
//  pokedex
//
//  Created by Soulxsense on 6/20/2559 BE.
//  Copyright © 2559 Soulxsense. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemon = [Pokemon]()
    var filterPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        initAudio()
        parsePokemonCSV()
        
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("DigimonSong", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            //musicPlayer.play()
            
        }catch let err as NSError {
            print(err.description)
        }
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")
        do{
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows{
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: id)
                pokemon.append(poke)
            }
        }catch let err as NSError{
            print(err.description)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCellCollectionViewCell", forIndexPath: indexPath) as? PokeCellCollectionViewCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filterPokemon[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]
            }

            cell.configureCell(poke)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        if inSearchMode {
            poke = filterPokemon[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
        performSegueWithIdentifier("DetailViewController", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }

    @IBAction func passMusic(sender: UIButton) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        }else {
            initAudio()
            musicPlayer.playing
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
            
        }else{
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filterPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewController" {
            if let detilVC = segue.destinationViewController as? DetailViewController {
                if let poke = sender as? Pokemon {
                    detilVC.pokemon = poke
                }
            }
        }
    }
}

