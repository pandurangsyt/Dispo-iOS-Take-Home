//
//  DetailViewModel.swift
//  Dispo Take Home
//
//  Created by Pandu on 1/9/22.
//

import Foundation

protocol DetailViewModelDelegate {
    func getGifById(id: String)
}

class DetailViewModel: DetailViewModelDelegate {
    weak var delegate: DetailViewControllerDelegate?
    let gifApiClient = GifAPIClient()
    
    init(delegate: DetailViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func getGifById(id: String) {
        gifApiClient.getGifById(id: id) { gifObject, error in
            guard let gifInfo = gifObject, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateUI(gifInfo)
            }
        }
    }
}

