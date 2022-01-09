//
//  MainViewModel.swift
//  Dispo Take Home
//
//  Created by Pandu on 1/9/22.
//

import Foundation

protocol MainViewModelDelegate {
    func getTrendingGifs()
    func searchGifs(searchText: String)
}

class MainViewModel: MainViewModelDelegate {
    weak var delegate: MainViewControllerDelegate?
    let gifApiClient = GifAPIClient()
    
    init(delegate: MainViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func getTrendingGifs() {
        gifApiClient.getTrendingGifs { gifs, error in
            DispatchQueue.main.async { [weak self] in
                guard let gifList = gifs?.data else { return }
                self?.delegate?.reloadCollection(gifList)
            }
        }
    }
    
    func searchGifs(searchText: String) {
        guard !searchText.isEmpty else {
            getTrendingGifs()
            return
        }
        gifApiClient.searchGifsByTerm(searchString: searchText) { gifs, error in
            DispatchQueue.main.async { [weak self] in
                guard let gifList = gifs?.data else { return }
                if gifList.count != 0 {
                    self?.delegate?.reloadCollection(gifList)
                } else {
                    self?.getTrendingGifs()
                }
            }
        }
    }
}
