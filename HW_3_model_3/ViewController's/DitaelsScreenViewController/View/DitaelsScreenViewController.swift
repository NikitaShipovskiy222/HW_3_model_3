//
//  DitaelsScreenViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 14/06/2024.
//

import UIKit

class DitaelsScreenViewController: UIViewController {
    
    private let noteManager = MakeNoteManager()
    var notes: [NoteProfile] = []

    
    private lazy var tabelView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .black
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))
    
    
    private lazy var makeRightButtonNav: UIBarButtonItem = {
        $0.tintColor = .main
        return $0
    }(UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(makeActionPlusButton)))
    
    
    //MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteManager.getNote { [weak self] note in
            guard let self = self else {return}
            self.notes = note
            self.tabelView.reloadData()
        }

    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addAllViews(tabelView)
        navigationItem.rightBarButtonItem = makeRightButtonNav
        navigationController?.navigationBar.tintColor = .main
        navigationItem.backButtonDisplayMode = .minimal
        
    }
    
    @objc
    func makeActionPlusButton() {
        present(MakeNoteViewController(), animated: true)
    }
    
}


extension DitaelsScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        let note = notes[indexPath.row]
        config.text = note.header
        config.textProperties.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        config.secondaryText = note.note
        config.secondaryTextProperties.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        config.image = UIImage(data: note.image ?? Data())
        config.imageProperties.maximumSize = CGSize(width: 56, height: 56)
        config.imageProperties.cornerRadius = 28
        cell.contentConfiguration = config
        cell.backgroundColor = .main
        return cell
    }
}

extension DitaelsScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.noteManager.deleteNote(id: notes[indexPath.row].id)
        notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let noteVC = LookNoteViewController()
        noteVC.titleImage = self.notes[indexPath.row].image
        noteVC.nameTitle = self.notes[indexPath.row].header
        noteVC.mainText = self.notes[indexPath.row].note
        navigationController?.pushViewController(noteVC, animated: true)
        
    }
}
