//
//  GameView.swift
//  JSON Parsing
//
//  Created by Георгий Маркарян on 22.05.2022.
//

import UIKit

class GameView: UIView {
    var json = JsonMetod()
    var squad: ResponseData?
    var selectedHero: Person?
    var winner: Person?
    var enemy: Person?

    private let gameView: UIView = {
        let gameView = UIView()
        gameView.translatesAutoresizingMaskIntoConstraints = false
        gameView.backgroundColor = .systemCyan
        return gameView
    }()

    var uiLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.font = UIFont(name:"HelveticaNeue", size: 32)
        uiLabel.textColor = .white
        uiLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        uiLabel.layer.shadowColor = UIColor.black.cgColor
        uiLabel.layer.shadowRadius = 5
        uiLabel.layer.shadowOpacity = 0.7
        uiLabel.adjustsFontSizeToFitWidth = true
        uiLabel.text = "Выберите персонажа"
        return uiLabel
    }()

    var youHero: UILabel = {
        let youHero = UILabel()
        youHero.translatesAutoresizingMaskIntoConstraints = false
        youHero.font = UIFont(name:"HelveticaNeue", size: 22)
        youHero.textColor = .white
        youHero.layer.shadowOffset = CGSize(width: 4, height: 4)
        youHero.layer.shadowColor = UIColor.black.cgColor
        youHero.layer.shadowRadius = 5
        youHero.layer.shadowOpacity = 0.7
        youHero.adjustsFontSizeToFitWidth = true
        youHero.alpha = 0
        return youHero
    }()

    var enemyHero: UILabel = {
        let enemyHero = UILabel()
        enemyHero.translatesAutoresizingMaskIntoConstraints = false
        enemyHero.font = UIFont(name:"HelveticaNeue", size: 22)
        enemyHero.textColor = .white
        enemyHero.layer.shadowOffset = CGSize(width: 4, height: 4)
        enemyHero.layer.shadowColor = UIColor.black.cgColor
        enemyHero.layer.shadowRadius = 5
        enemyHero.layer.shadowOpacity = 0.7
        enemyHero.adjustsFontSizeToFitWidth = true
        enemyHero.alpha = 0
        return enemyHero
    }()

    var whoWinner: UILabel = {
        let whoWinner = UILabel()
        whoWinner.translatesAutoresizingMaskIntoConstraints = false
        whoWinner.font = UIFont(name:"HelveticaNeue", size: 22)
        whoWinner.textColor = .white
        whoWinner.layer.shadowOffset = CGSize(width: 4, height: 4)
        whoWinner.layer.shadowColor = UIColor.black.cgColor
        whoWinner.layer.shadowRadius = 5
        whoWinner.layer.shadowOpacity = 0.7
        whoWinner.adjustsFontSizeToFitWidth = true
        whoWinner.alpha = 0
        return whoWinner
    }()

    var warning: UILabel = {
        let warning = UILabel()
        warning.translatesAutoresizingMaskIntoConstraints = false
        warning.font = UIFont(name:"HelveticaNeue", size: 12)
        warning.textColor = .red
        warning.layer.shadowOffset = CGSize(width: 4, height: 4)
        warning.layer.shadowColor = UIColor.black.cgColor
        warning.layer.shadowRadius = 5
        warning.layer.shadowOpacity = 0.7
        warning.adjustsFontSizeToFitWidth = true
        warning.alpha = 0
        warning.text = "Выберите персонажа"
        return warning
    }()

    private lazy var selectHero: UIPickerView = {
        let selectHero = UIPickerView()
        selectHero.translatesAutoresizingMaskIntoConstraints = false
        selectHero.backgroundColor = .systemCyan
        selectHero.layer.shadowOffset = CGSize(width: 4, height: 4)
        selectHero.layer.shadowColor = UIColor.black.cgColor
        selectHero.layer.shadowRadius = 5
        selectHero.layer.shadowOpacity = 0.7
        selectHero.layer.cornerRadius = 10

        selectHero.delegate = self
        selectHero.dataSource = self

        return selectHero
    }()

    var selectButton: UIButton = {
        let selectButton = UIButton()
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.layer.cornerRadius = 10
        selectButton.setTitle("Подтвердить выбор", for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.backgroundColor = .darkGray
        selectButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        return selectButton
    }()

    var backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.layer.cornerRadius = 10
        backButton.setTitle("Начать заново", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .darkGray
        backButton.alpha = 0
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return backButton
    }()

    @objc private func selectButtonAction(){

        UIView.animate(withDuration: 0.1,
                       animations: {
            self.selectButton.alpha = 0.5
        }) { (completed) in
            UIView.animate(withDuration: 0.5,
                           animations: {
                self.selectButton.alpha = 1
            })
        }
       if selectedHero != nil {
           UIView.animate(withDuration: 0.8,
                          animations: { [self] in
               selectHero.alpha = 0
               warning.alpha = 0
               gameView.backgroundColor = .red
               youHero.text = selectedHero?.name
               enemy = squad?.members[Int.random(in: 0...2)]
               enemyHero.text = enemy?.name
               uiLabel.font = UIFont(name:"HelveticaNeue", size: 18)
               uiLabel.text = "Кто победит узнаем через секунду.."
               selectButton.alpha = 0
               backButton.alpha = 1
               youHero.alpha = 1
               enemyHero.alpha = 1
           }) { (completed) in
               UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn) { [self] in
                   whoWinner.alpha = 1
                   winner = [enemy, selectedHero][Int.random(in: 0...1)]
                   UIView.animate(withDuration: 2, delay: 2, options: .curveEaseIn) {
                       guard let whoWinner = winner else {return}
                       self.whoWinner.text = "Победа достается \(whoWinner.name)"
                       //
                       guard var squad = squad else { return }
                       print(squad)
                       let index = squad.members.firstIndex(where: {$0.name == whoWinner.name})!
                       squad.members[index].wins += 1
                       print(squad.members)

                       json.saveJson(fileName: "JSONexample", model: squad)
                       self.squad = json.loadJson(filename: "JSONexample")

                       //

                   }
               }
           }
       } else {
           UIView.animate(withDuration: 0.1,
                          animations: {
               self.warning.alpha = 0.5
           }) { (completed) in
               UIView.animate(withDuration: 0.5,
                              animations: {
                   self.warning.alpha = 1
               })
           }
       }
    }

    @objc private func backButtonAction(){
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.selectButton.alpha = 0.5
        }) { (completed) in
            UIView.animate(withDuration: 0.5,
                           animations: {
                self.selectButton.alpha = 1
            })
        }
        UIView.animate(withDuration: 0.8,
                       animations: { [self] in
            selectHero.alpha = 1
            gameView.backgroundColor = .systemCyan
            uiLabel.font = UIFont(name:"HelveticaNeue", size: 32)
            uiLabel.text = "Выберите персонажа"
            selectButton.setTitle("Подтвердить выбор", for: .normal)
            selectButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
            selectButton.removeTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
            whoWinner.alpha = 0
            selectButton.alpha = 1
            backButton.alpha = 0
            youHero.alpha = 0
            enemyHero.alpha = 0
        })
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        squad = json.loadJson(filename: "JSONexample")

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout(){
        addSubview(gameView)
        [uiLabel, selectHero, selectButton, backButton, youHero, enemyHero, whoWinner, warning].forEach {gameView.addSubview($0)}

        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: topAnchor),
            gameView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            gameView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            uiLabel.topAnchor.constraint(equalTo: gameView.safeAreaLayoutGuide.topAnchor, constant: 30),
            uiLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),

            youHero.topAnchor.constraint(equalTo: uiLabel.bottomAnchor, constant: 30),
            youHero.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),

            selectHero.topAnchor.constraint(equalTo: uiLabel.topAnchor, constant: 90),
            selectHero.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),

            enemyHero.topAnchor.constraint(equalTo: selectHero.bottomAnchor, constant: 15),
            enemyHero.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),

            selectButton.topAnchor.constraint(equalTo: selectHero.bottomAnchor, constant: 60),
            selectButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 100),
            selectButton.widthAnchor.constraint(equalToConstant: 300),

            backButton.topAnchor.constraint(equalTo: selectHero.bottomAnchor, constant: 60),
            backButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 100),
            backButton.widthAnchor.constraint(equalToConstant: 300),

            whoWinner.topAnchor.constraint(equalTo: youHero.bottomAnchor, constant: 90),
            whoWinner.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),

            warning.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 20),
            warning.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
        ])
    }
}

// MARK: - UITextFieldDelegate
extension GameView: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let members = squad?.members else {return}
        selectedHero = members[row]
    }
}


// MARK: - UITextFieldDataSourse
extension GameView: UIPickerViewDataSource{


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let members = squad?.members else {return 0}

        return members.count
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let members = squad?.members else {return ""}
        let row = members[row].name
        return row
    }


}
