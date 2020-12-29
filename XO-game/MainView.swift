import UIKit

class MainView: UIView {
    
    let playWithComputerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Играть с компьютером", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemGreen
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.cornerRadius = 20
        button.tag = 1
        return button
    }()
    
    let playWithHumanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Игра с двумя игроками", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemGreen
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.cornerRadius = 20
        button.tag = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            playWithComputerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playWithComputerButton.widthAnchor.constraint(equalToConstant: 280),
            playWithComputerButton.heightAnchor.constraint(equalToConstant: 40),
            playWithComputerButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            playWithHumanButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playWithHumanButton.widthAnchor.constraint(equalToConstant: 280),
            playWithHumanButton.heightAnchor.constraint(equalToConstant: 40),
            playWithHumanButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30)
        ])
    }
    
    func setup() {
        backgroundColor = .systemGreen
        addSubview(playWithComputerButton)
        addSubview(playWithHumanButton)
        updateConstraints()
    }
}


