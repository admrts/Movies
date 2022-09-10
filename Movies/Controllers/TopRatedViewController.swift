//
//  TopRatedViewController.swift
//  Movies
//
//  Created by Ali Demirtaş on 4.09.2022.
//

import UIKit

class TopRatedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesManager = MoviesManager()
    var labelArray = [Results]()
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        moviesManager.delegate = self
        moviesManager.fetchMovies(pageName: "top_rated")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let i = sender as! Int
        let goVC = segue.destination as! DetailViewController
        goVC.movieTitle = labelArray[i].title
        goVC.overview = labelArray[i].overview
        goVC.imageUrl = labelArray[i].poster_path
    }
}
//MARK: - Tableview Delegate & Datasource
extension TopRatedViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return labelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toprated",for: indexPath)
        cell.textLabel?.text = labelArray[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
}
//MARK: - MoviewManager Delegate
extension TopRatedViewController: MoviesManagerDelegate {
    func didUpdateMovies(movie: [Results]) {
        
        DispatchQueue.main.async {
            self.labelArray = movie
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

