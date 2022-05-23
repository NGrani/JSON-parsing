//
//  ViewController.swift
//  JSON Parsing
//
//  Created by Георгий Маркарян on 20.05.2022.
//

import UIKit

class GameViewController: UIViewController {

    private let gameView: UIView = {
        let gameView = GameView()
        gameView.translatesAutoresizingMaskIntoConstraints = false
        return gameView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func layout() {
        view.addSubview(gameView)

        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    
}



