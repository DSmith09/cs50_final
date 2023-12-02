//
//  ViewController.swift
//  cs50_final
//
//  Created by David Smith on 12/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeSetTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    var seconds: Int! {
        didSet {
            timerLabel.text = getTime(for: TimeInterval(seconds))
        }
    }
    var timer: Timer?
    var isTimerRunning = false {
        didSet {
            pauseButton.titleLabel?.text = isTimerRunning ? "Pause" : "Resume"
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        guard !isTimerRunning else { return }
        startTimer()
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if isTimerRunning {
            pauseTimer()
        } else {
            resumeTimer()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer()
        resetTimer()
    }
    
    private func resetTimer() {
        pauseTimer()
        seconds = 0
    }
    
    private func startTimer() {
        seconds = Int(timeSetTextField.text ?? "0") ?? 0
        resumeTimer()
    }
    
    private func resumeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    
    private func endTimer() {
        let alert = UIAlertController(title: "Times Up!", message: "Your timer has ended", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: resetTimer)
    }
    
    @objc private func updateTimer() {
        if seconds < 1 {
            endTimer()
        } else {
            seconds -= 1
        }
    }
    
    private func getTime(for time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
