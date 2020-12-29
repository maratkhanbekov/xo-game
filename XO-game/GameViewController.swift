//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

enum GameMode {
    case computer, human, blind
}

class GameViewController: UIViewController {
    
    // Класс, который после каждого хода проверяет не выиграл ли кто
    private lazy var referee = Referee(gameboard: self.gameboard)
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    var gameMode: GameMode?
    var roundCounter = 1
    
    private let gameboard = Gameboard()
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Вызовом self.goToFirstState() устанавливаем начальное состояние
        self.goToFirstState()

        // Также добавляем обработку нажатия юзера на ячейку поля. По такому нажатию у текущего состояния вызываем addMark, и далее, если состояние «завершено», переходим к следующему.
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                // Если против компьютера
                guard let gameMode = self.gameMode else { return }
                if gameMode == .computer {
                    self.computerMove()
                }
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        let player = Player.first
        
        
        guard let gameMode = gameMode else { return }
        
        if gameMode == .blind {
            self.currentState = PlayerInputBlindState(player: .first,
                                                 markViewPrototype: player.markViewPrototype,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
        }
        else {
            // Итак, установка первого состояния — это установка PlayerInputState с первым игроком
            self.currentState = PlayerInputState(player: .first,
                                                 markViewPrototype: player.markViewPrototype,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
        }
       
    }
    
    private func goToNextState() {
        
        if roundCounter >= 9 {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }
        
        
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        guard let gameMode = gameMode else { return }
        
        if gameMode == .computer {
            if let playerInputState = currentState as? ComputerInputState {
                self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                     markViewPrototype:playerInputState.player.next.markViewPrototype,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
            }
        }
        else if gameMode == .human {
            if let playerInputState = currentState as? PlayerInputState {
                self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                     markViewPrototype:playerInputState.player.next.markViewPrototype,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
            }
            
        }
        else if gameMode == .blind {
            if let playerInputBlindState = currentState as? PlayerInputBlindState {
                self.currentState = PlayerInputBlindState(player: playerInputBlindState.player.next,
                                                     markViewPrototype:playerInputBlindState.player.next.markViewPrototype,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
            }
        }
        
        
        roundCounter += 1
    }
    
    func computerMove() {
        if let playerInputState = currentState as? PlayerInputState {
            
            // Меняем на следующего игрока - O
            self.currentState = ComputerInputState(player: playerInputState.player.next,
                                                   markViewPrototype: playerInputState.player.next.markViewPrototype,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
            
            
            var emptyPositions: [(Int, Int)] = []
            
            // Определяем свободные клетки
            for i in 0...2 {
                for j in 0...2 {
                    if gameboardView.canPlaceMarkView(at: GameboardPosition(column: i, row: j)) {
                        emptyPositions.append((i, j))
                    }
                    
                }
            }
            // Ставим случайную метку
            if emptyPositions.count > 0 {
                let position = emptyPositions[Int.random(in: 0..<emptyPositions.count)]
            self.currentState.addMark(at: GameboardPosition(column: position.0, row: position.1))
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        gameboard.clear()
        gameboardView.clear()
        goToFirstState()
        //        self.dismiss(animated: true, completion: nil)
    }
}

