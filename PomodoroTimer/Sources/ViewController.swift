//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Дима Кондратенко on 07.11.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "00:00"
        timerLabel.textColor = .red
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 50)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timerLabel
    }()
    
    private lazy var playPauseButton: UIButton = {
        let playPauseButton = UIButton()
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playPauseButton.tintColor = .red
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        playPauseButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        return playPauseButton
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(timerLabel)
        view.addSubview(playPauseButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            playPauseButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 50),
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    
}

