//
//  TitleCollectionViewCell.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 03/06/2024.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "TitleCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: contentView.bounds))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [posterImageView].forEach{
            addSubview($0)

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }

}
