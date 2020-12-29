//
//  MainViewController.swift
//  XO-game
//
//  Created by Marat Khanbekov on 28.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    let rootView = MainView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        
        rootView.playWithHumanButton.addTarget(self, action: #selector(pressPlayButton(_:)), for: .touchUpInside)
        rootView.playWithComputerButton.addTarget(self, action: #selector(pressPlayButton(_:)), for: .touchUpInside)
        rootView.playBlindButton.addTarget(self, action: #selector(pressPlayButton(_:)), for: .touchUpInside)
    }
    
    @objc
    func pressPlayButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.modalPresentationStyle = .fullScreen
        
        switch sender.tag {
        case 1:
            gameViewController.gameMode = .computer
            self.present(gameViewController, animated: true, completion: nil)
        case 2:
            gameViewController.gameMode = .human
            self.present(gameViewController, animated: true, completion: nil)
        case 3:
            gameViewController.gameMode = .blind
            self.present(gameViewController, animated: true, completion: nil)
        default:
            print("error")
        }
    }
}
