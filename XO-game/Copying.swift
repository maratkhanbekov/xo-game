//
//  Copying.swift
//  XO-game
//
//  Created by Marat Khanbekov on 28.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}

