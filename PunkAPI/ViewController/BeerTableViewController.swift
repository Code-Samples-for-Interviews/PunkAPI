//
//  BeerTableViewController.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import UIKit

class BeerTableViewController: UITableViewController, UISearchBarDelegate {
    
    // Search controller
    var searchBar : UISearchBar!
    var currentSearch: String!
    var searchPage: Int = 1
    var fetchingMore: Bool = false
    let threshold = 100.0 // threshold from bottom of tableView
        
    // API Remote Request
    let apiService = APIService()
    
    // Data source for tableview
    var beerViewModelSource:[BeerViewModel] = [] {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        initSetupView()

    }
    
    // MARK: - NavigationBar setup
    private func initSetupView() {
        // Set title
        self.title = "PunkAPI App"
    }
    
    
    // MARK: - Forced data reload
    
    @objc func searchBeersForFood(food: String) {
        self.apiService.fetchBeersForFood(search: food, page: searchPage, completion: { [weak self] (error, beers) in
            guard let strongSelf = self else { return }
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            // Set initial call for beers
            if self!.searchPage == 1 {
                strongSelf.beerViewModelSource = beers
            }else{
                strongSelf.beerViewModelSource.append(contentsOf: beers)
            }
            // Data reload
            self?.tableView.reloadData()
        })
    }
        
    // MARK: - Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            self.searchPage = 1
            beerViewModelSource = []
            self.tableView.reloadData()
        }else{
            currentSearch = searchBar.text!
            searchBeersForFood(food: searchBar.text!)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beerViewModelSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.cellReuseIdentifier, for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        // Configure the cell...
        let beerViewModel = beerViewModelSource[indexPath.row]
        cell.configure(with: beerViewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        self.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y
        if !fetchingMore && (maximumOffset < CGFloat(threshold)) {
            // Get more data - API call
            self.fetchingMore = true
            // Update UI
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                //self.tableView.reloadData()
                self.fetchingMore = false
                if self.currentSearch != nil {
                    self.searchPage += 1
                    self.searchBeersForFood(food: self.currentSearch)
                }
            })
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetailSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let controller = segue.destination as? DetailViewController {
            controller.beer = beerViewModelSource[indexPath.row]
            // Deselect current selected cell
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    
}
