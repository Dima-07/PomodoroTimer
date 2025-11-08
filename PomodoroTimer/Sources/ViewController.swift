//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Дима Кондратенко on 07.11.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var isWorkTime: Bool = true
    private var isStarted: Bool = false
    
    // Время (в секундах)
    private let workTime = 25
    private let breakTime = 10
    
    // Текущее оставшееся время
    private var remainingTime = 0
    
    // Объект таймера
    private var timer: Timer?
    
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
    
    private lazy var resetButton: UIButton = {
        let resetButton = UIButton()
        resetButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        resetButton.tintColor = .gray
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        resetButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        return resetButton
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupInitialState()
        setupButtonActions()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(timerLabel)
        view.addSubview(playPauseButton)
        view.addSubview(resetButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            resetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 50),
            resetButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            
            playPauseButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 50),
            playPauseButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20)
        ])
    }
    
    // MARK: - Timer Methods
    
    private func setupInitialState() {
        remainingTime = isWorkTime ? workTime : breakTime
        updateTimerLabel()
        updateColors()
    }
    
    private func updateTimerLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func updateColors() {
        if isWorkTime {
            // Режим работы - красная цветовая схема
            timerLabel.textColor = .red
            playPauseButton.tintColor  = .red
            resetButton.tintColor = .red
            view.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        } else {
            // Режим отдыха - зеленая цветовая схема
            timerLabel.textColor = .green
            playPauseButton.tintColor = .green
            resetButton.tintColor = .green
            view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        }
    }
    
    private func setupButtonActions() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    private func startTimer() {
        isStarted = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        updateButtonAppearance()
    }
    
    private func pauseTimer() {
        isStarted = false
        timer?.invalidate()
        timer = nil
        updateButtonAppearance()
    }
    
    private func resetTimer() {
        pauseTimer()
        remainingTime = isWorkTime ? workTime : breakTime
        updateTimerLabel()
    }
    
    private func switchMode() {
        isWorkTime.toggle()
        remainingTime = isWorkTime ? workTime : breakTime
        updateTimerLabel()
        updateColors()
    }
    
    private func updateButtonAppearance() {
        let imageName = isStarted ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // MARK: - Actions
    
    @objc private func playPauseButtonTapped() {
        if isStarted {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    @objc private func timerTick() {
        remainingTime -= 1
        updateTimerLabel()
        if remainingTime <= 0 {
            switchMode()
        }
    }
    
    @objc private func resetButtonTapped() {
        resetTimer()
    }
    
}

