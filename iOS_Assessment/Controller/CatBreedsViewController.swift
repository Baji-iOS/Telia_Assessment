//
//  CatBreedsViewController.swift
//  iOS_Assessment
//
//  Created by Baji on 07/06/22.
//

import UIKit

class CatBreedsViewController: UIViewController {
    var catBreedsDataModel = [CatBreedsDataModel]()
    @IBOutlet weak var search_CatBreeds: UISearchBar!
    @IBOutlet weak var tbl_CatBreeds: UITableView!
    
    var isCatBreedSearch = Bool()
    private var isCatSort = Bool()
    private var array_CatBreedNames = [CatBreedsDataModel]()
    var filteredContentList = [CatBreedsDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.search_CatBreeds.backgroundImage = UIImage()
        getCatBreedsData()
    }
    
    func getCatBreedsData() {
        CatBreedsViewModel.getCatBreedsData { (catBreeds) in
            DispatchQueue.main.async {
                self.catBreedsDataModel = catBreeds
                self.tbl_CatBreeds.reloadData()
            }
        }
    }
}

// MARK: - Actions
extension CatBreedsViewController {
    
    @IBAction func btn_SortAction(_ sender: UIButton) {
        sortCatBreeds()
    }
    
    func sortCatBreeds() {
        if isCatBreedSearch == true {
            if isCatSort == true {
                isCatSort = false
                self.filteredContentList.sort { $0.name ?? "" < $1.name ?? "" }
            } else {
                isCatSort = true
                self.filteredContentList.sort { $0.name ?? "" > $1.name ?? "" }
            }
        } else {
            if isCatSort == true {
                isCatSort = false
                self.catBreedsDataModel.sort { $0.name ?? "" < $1.name ?? "" }
            } else {
                isCatSort = true
                self.catBreedsDataModel.sort { $0.name ?? "" > $1.name ?? "" }
            }
        }
        self.tbl_CatBreeds.reloadData()
    }
}

// MARK: - Search Bar Delegates
extension CatBreedsViewController: UISearchBarDelegate {
    func searchCatBreedstableRefreshData() {
        let searchString: String = self.search_CatBreeds.text ?? ""
        self.array_CatBreedNames.removeAll()
        self.array_CatBreedNames = self.catBreedsDataModel
        for tempStr in self.array_CatBreedNames {
            if tempStr.name?.count ?? 0 >= searchString.count {
                let result: ComparisonResult = ((tempStr.name ?? "") as NSString).compare(searchString, options: ([.caseInsensitive, .diacriticInsensitive, .literal]), range: NSRange(location: 0, length: (searchString.count )))
                if result == .orderedSame && !(filteredContentList.contains(where: {
                                                                                $0.name == tempStr.name })) {
                    filteredContentList.append(tempStr)
                }
            }
        }
        
        if filteredContentList.count <= 0 {
            tbl_CatBreeds.isHidden = true
            tbl_CatBreeds.reloadData()
        }
        else {
            tbl_CatBreeds.isHidden = false
            tbl_CatBreeds.reloadData()
        }
        self.tbl_CatBreeds.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tbl_CatBreeds?.isUserInteractionEnabled = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isCatBreedSearch = false
        
        tbl_CatBreeds?.isUserInteractionEnabled = false
        if searchText.count > 0 {
            isCatBreedSearch = true
            self.filteredContentList.removeAll()
            searchCatBreedstableRefreshData()
        } else {
            isCatBreedSearch = false
            self.filteredContentList.removeAll()
            self.tbl_CatBreeds?.isHidden = false
        }
        self.tbl_CatBreeds?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        tbl_CatBreeds?.isUserInteractionEnabled = true
        isCatBreedSearch = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tbl_CatBreeds?.isUserInteractionEnabled = true
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        self.tbl_CatBreeds?.reloadData()
    }
}
