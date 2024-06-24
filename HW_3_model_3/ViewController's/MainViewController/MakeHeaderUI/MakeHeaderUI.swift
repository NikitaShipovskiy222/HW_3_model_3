//
//  HeaderUIView.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 02/06/2024.
//

import UIKit


//MARK: - HeaderUIView
class HeaderUIView: UIView {
    
    private lazy var playButton: UIButton = {
        .config(view: $0) { button in
            button.setTitle("Играть", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = 5
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }(UIButton())
    
    private lazy var downButton: UIButton = {
        .config(view: $0) { down in
            down.setTitle("Скачать", for: .normal)
            down.setTitleColor(.white, for: .normal)
            down.layer.borderWidth = 1
            down.layer.borderColor = UIColor.white.cgColor
            down.layer.cornerRadius = 5
            down.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }(UIButton())
    
    
    private lazy var mainImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    //MARK:  initilization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImage)
        addGradient()
        addSubview(playButton)
        addSubview(downButton)
        playConstraint()

    }
    
    private func playConstraint() {
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            downButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            downButton.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
        
        ])
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp\(model.posterURL)") else {return}
        mainImage.sd_setImage(with: url, completed: nil)
    }
    //MARK:  LayoutSubviews
    override func layoutSubviews() {
        mainImage.frame = bounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
