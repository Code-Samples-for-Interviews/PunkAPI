//
//  DetailViewController.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import UIKit

class DetailViewController: UIViewController {

    var beer: BeerViewModel?
    
    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var abv_ibu:UILabel!

    @IBOutlet weak var descriptionTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBar()
        setupDetailView()
    }
    
    // MARK: - NavigationBar setup
    private func setupNavBar() {
        self.title = beer?.nameText
    }
    
    // MARK: - Setup content data
    private func setupDetailView() {
        //self.picture.sd_setImage(with: beerViewModel.pictureUrl)
        image.sd_setImage(with: beer?.pictureUrl)
        abv_ibu.text = String("ABV: \(beer?.abvText ?? "???")% - IBU: \(beer?.ibuText ?? "???")")
        descriptionTxt.text = beer?.descriptionText
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
