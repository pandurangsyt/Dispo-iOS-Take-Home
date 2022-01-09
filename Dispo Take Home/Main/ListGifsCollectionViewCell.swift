//
//  ListGifsCollectionViewCell.swift
//  Dispo Take Home
//
//  Created by Pandu on 1/5/22.
//

import UIKit
import Kingfisher

class ListGifsCollectionViewCell: UICollectionViewCell {    
    private lazy var gifImage: UIImageView = {
        let gif = UIImageView()
        gif.snp.makeConstraints { 
            $0.width.height.equalTo(80)
        }
        return gif
    }()
    
    private lazy var gifTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20, weight: .regular)
        title.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupCell(_ gifModel: SearchResult) {
        gifTitle.text = gifModel.title        
        gifImage.kf.setImage(with: gifModel.gifUrl)
    }
    
    private func setupUI() {
        self.addSubview(gifImage)
        self.addSubview(gifTitle)
        setupConstraints()
    }
    
    private func setupConstraints() {
        gifImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
        }
        gifTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(gifImage.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
        }
    }
}
