//
//  InputInvoker.swift
//  XO-game
//
//  Created by Marat Khanbekov on 29.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class Command {
    var player: Player
    var position: GameboardPosition
    var gameBoard: Gameboard
    var markViewPrototype: MarkView
    
    init(player: Player, position: GameboardPosition, gameBoard: Gameboard, markViewPrototype: MarkView) {
        self.player = player
        self.position = position
        self.gameBoard = gameBoard
        self.markViewPrototype = markViewPrototype
    }
    
    func execute() {
        print("Command executed")
    }
}

class InputInvoker {
    
    var changePlayerClosure: (() -> Void)?
    var drawMarksClosure: ((Command) -> Void)?
    
    // MARK: Singleton
    internal static let shared = InputInvoker()
    
    var commands: [Command] = []
    let batchSize = 10
    
    func addCommand(_ command: Command) {
        commands.append(command)
        
        changePlayerIfNeeded()
        executeCommandsIfNeeded()
    }
    
    private func changePlayerIfNeeded() {
        guard self.commands.count == self.batchSize/2 else { return }
        changePlayerClosure?()
    }
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count == self.batchSize else { return }
        
        self.commands.forEach{
            $0.execute()
            drawMarksClosure?($0)
        }
        self.commands = []
    }
 
}
