//
//  CatBreedsViewController.swift
//  iOS_Assessment
//
//  Created by Baji on 07/06/22.
//

import UIKit

class CatBreedsViewController: UIViewController {
    
    var catBreedsDataModel = [CatBreedsDataModel]()
    @IBOutlet weak var tbl_CatBreeds: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
