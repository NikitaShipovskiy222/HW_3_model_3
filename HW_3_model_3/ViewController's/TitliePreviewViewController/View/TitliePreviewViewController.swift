//
//  TitliePreviewViewController.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 04/06/2024.
//

import UIKit
import WebKit

class TitliePreviewViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        .config(view: $0) { label in
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
    }(UILabel())
    
    private lazy var overviewLabel: UILabel = {
        .config(view: $0) { label in
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            label.numberOfLines = 0
        }
    }(UILabel())
    
    private lazy var downlodButton: UIButton = {
        .config(view: $0) { button in
            button.backgroundColor = UIColor(named: "mainColor")
            button.setTitle("Скачать", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.widthAnchor.constraint(equalToConstant: 120).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
        }
    }(UIButton())
    
    private lazy var webView: WKWebView = {
        .config(view: $0) { web in
            web.heightAnchor.constraint(equalToConstant: 250).isActive = true
        }
    }(WKWebView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        [webView, titleLabel, overviewLabel, downlodButton].forEach{
            view.addSubview($0)
        }

        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            
            downlodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downlodButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25)
        ])
    }
    
     func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        webView.load(URLRequest(url: url))
    }


}
