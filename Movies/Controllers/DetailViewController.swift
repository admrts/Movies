//
//  DetailViewController.swift
//  Movies
//
//  Created by Ali Demirtaş on 10.09.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieTitle = ""
    var overview = ""
    var imageUrl = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = movieTitle
        overviewLabel.text = overview
        loadImage()
    }
    func loadImage() {
        do {
            let data = try Data(contentsOf: URL(string:Api.mainImageUrl+imageUrl)!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        catch {
            print("Image Loading Error \(error)")
        }
    }
}

