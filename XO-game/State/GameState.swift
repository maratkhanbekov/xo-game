//
//  GameState.swift
//  XO-game
//
//  Created by Marat Khanbekov on 28.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isCompleted: Bool { get }
    func begin()
    func addMark(at position: GameboardPosition)
}
