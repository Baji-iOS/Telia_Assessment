//
//  CatBreedsViewModel.swift
//  iOS_Assessment
//
//  Created by Baji on 07/06/22.
//

import Foundation
import UIKit

class CatBreedsViewModel: NSObject {
    static func getCatBreedsData(data: @escaping( [CatBreedsDataModel] )-> Void) {
        NetworkManager.hitapi(success: { (catbreedsdata) in
            data(catbreedsdata)
        }) { (failed) in
            
        }
    }
}

extension CatBreedsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catBreedsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catbreedscell")
        let lbl = cell?.contentView.viewWithTag(1) as? UILabel
        lbl?.text = catBreedsDataModel[indexPath.row].name
        return cell ?? UITableViewCell()
    }
}
