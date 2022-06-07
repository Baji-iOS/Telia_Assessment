//
//  APIManager.swift
//  iOS_Assessment
//
//  Created by Baji on 07/06/22.
//

import Foundation

typealias failure = (String) -> Void

class NetworkManager {
    
    static func hitapi(success:@escaping([CatBreedsDataModel]) -> (), failure: @escaping failure) {
        guard let url = URL(string: getCatBreeds) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        DispatchQueue.main.async {
            ProgressView.shared.startAnimating()
        }
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            defer {
                DispatchQueue.main.async {
                    ProgressView.shared.stopAnimatimating()
                }
            }
            if data != nil {
                do {
                    let catBreedsData = try? JSONDecoder().decode([CatBreedsDataModel].self, from: data! )
                    success(catBreedsData!)
                } catch {
                    failure("Something went wrong.")
                }
            } else {
                failure("Something went wrong.")
            }
        }).resume()
    }
}
