//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Marat Khanbekov on 28.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation


public class PlayerInputBlindState: GameState {

    
    public private(set) var isCompleted = false
    public let markViewPrototype: MarkView
    
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    public func begin() {
        
        InputInvoker.shared.changePlayerClosure = { [weak self] in
            self?.isCompleted = true
        }
        
        InputInvoker.shared.drawMarksClosure = { [weak self] command in
            
            guard let self = self else { return }
            
            self.gameboard?.setPlayer(command.player, at: command.position)
            
            if self.gameboardView?.canPlaceMarkView(at: command.position) == false {
                self.gameboardView?.removeMarkView(at: command.position)
            }
            
            self.gameboardView?.placeMarkView(command.markViewPrototype, at: command.position)
            self.isCompleted = true
        }
        
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        
        Log(.playerInput(player: self.player, position: position))

        let command = Command(player: self.player, position: position, gameBoard: self.gameboard!, markViewPrototype: self.markViewPrototype.copy())
        
        InputInvoker.shared.addCommand(command)
    }
}
