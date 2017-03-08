//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! CustomTableViewCell
        selectedIndexPath = indexPath
        if let image = cachedImages[indexPath.row] {
            cell.pokeImage.image = image // may need to change this!
            
        } else {
            let pokemon = pokemonArray?[indexPath.row]
            let url = URL(string: (pokemon?.imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.pokeImage.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        cell.pokeName.text = pokemonArray![indexPath.row].name
        cell.pokeNum.text = String(pokemonArray![indexPath.row].number)
        var stats = String(pokemonArray![indexPath.row].attack)
        stats = stats + "/"
        stats = stats + String(pokemonArray![indexPath.row].defense) + "/" + String(pokemonArray![indexPath.row].health)
        cell.pokeStats.text = stats
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "CategoryToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "CategoryToInfo" {
                if let dest = segue.destination as? PokemonInfoViewController {
                    dest.image = cachedImages[(selectedIndexPath?.row)!]
                    dest.pokemon = pokemonArray?[(selectedIndexPath?.row)!]
                }
            }
        }
    }


}
