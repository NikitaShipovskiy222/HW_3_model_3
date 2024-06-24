//
//  ViewController.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 29/05/2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    var networkSerice: Network! {get set}
}

enum Section: Int {
    case movieForYou = 0
    case moviePopular = 1
    case movieAllFameliy = 2
    
}

//MARK: - MainViewController
class MainViewController: UIViewController {
    
    var networkSerice: Network = APICaller()
    
    private var randomTitleMovie: Movie?
    private var headerView: HeaderUIView?
    
    let sectionTitle: [String] = ["Фильмы для вас", "Популярные фильмы", "Фильмы для всей семьи"]
    
    private lazy var tableView: UITableView = {
        $0.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.resulId)
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .black
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    
    //MARK:  ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        configurNavBar()
        configureHeroHeaderView()
        view.backgroundColor = .black
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.sendRequest { [weak self] result in
            switch result {
            case .success(let title):
                let selectTitile = title.randomElement()
                self?.randomTitleMovie = selectTitile
                
                self?.headerView?.configure(with: TitleViewModel(titleName: selectTitile?.posterURLPreview ?? "logo2", posterURL: selectTitile?.posterURL ?? "logo2"))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK:  ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configurNavBar() {
        
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = UIColor(named: "mainColor")
    }
    

    
}


//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defualtOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defualtOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

//MARK:  UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 10, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.backgroundColor = .black
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.resulId, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        switch indexPath.section {
            
        case Section.movieForYou.rawValue:
            
            APICaller.shared.sendRequest { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Section.moviePopular.rawValue:
            APICaller.shared.sendRequest { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error)
                }
                
            }
            
        case Section.movieAllFameliy.rawValue:
            APICaller.shared.sendRequest { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error)
                }
                
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    
}

extension MainViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let TitliePreviewVC = TitliePreviewViewController()
            TitliePreviewVC.configure(with: viewModel)
            self?.navigationController?.pushViewController(TitliePreviewVC, animated: true)
        }

    }
}
