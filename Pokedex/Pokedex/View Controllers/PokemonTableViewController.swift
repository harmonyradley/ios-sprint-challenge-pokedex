//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    let pokemonController = PokemonController()
    
    var pokemon: Pokemon? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           tableView.reloadData()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let addedPokemon = pokemonController.pokemonArray[indexPath.row]
        
        cell.textLabel?.text = addedPokemon.name.capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemonArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonViewSegue" {
            guard let destination = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.pokemon = pokemonController.pokemonArray[indexPath.row]
            destination.pokemonController = pokemonController
        } else if segue.identifier == "SearchPokemonSegue" {
            guard let destination = segue.destination as? PokemonDetailViewController else { return }
            destination.pokemonController = self.pokemonController
        }
    }
}
