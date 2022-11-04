//
//  CardSelectionVC.swift
//  CardWorkoutProgrammatic
//
//  Created by Alper Koçer on 3.11.2022.
//

import UIKit

class CardSelectionVC: UIViewController {
    
    let cardImageView = UIImageView()
    let stopButton = CWButton(color: .systemRed, title: "Stop!", systemImageName: "stop.circle")
    let resetButton = CWButton(color: .systemGreen, title: "Reset", systemImageName: "arrow.clockwise.circle")
    let rulesButton = CWButton(color: .systemBlue, title: "Rules", systemImageName: "list.bullet")
    
    var cards: [UIImage] = CardDeck.allValues //array of cards
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showRandomImage), userInfo: nil, repeats: true)
    }
    
    @objc func stopTimer() {
        //when we're using #selector we're interacting with objective-c at a lower level. that's why we declare the function as a @objc method.
        timer.invalidate()
    }
    
    @objc func resetTimer() {
        timer.invalidate()
        startTimer()
    }
    
    @objc func showRandomImage() {
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS")
    }
    
    func configureUI() {
        //the order matters
        
        configureCardImageView()
        configureStopButton()
        configureResetButton()
        configureRulesButton()
    }

    func configureCardImageView() {
        view.addSubview(cardImageView) //storyboard = dragging the element on the view
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.image = UIImage(named: "AS")
        
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 250), //width
            cardImageView.heightAnchor.constraint(equalToConstant: 350), //height
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //center horizontally, with the view's x anchor
            cardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75) //center vertically with the view's y anchor and move 75 points up
        ])
    }
    
    func configureStopButton() {
        view.addSubview(stopButton)
        //we don't have to write translatesAutoresizing... because in CWButton we included that line. Every CWButton instance have it.
        
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30) //pin to the bottom of the cardImageView
            
            /*
             we can't pin something to the cardImageView until the cardImageView is laid out.
             if the cardImageView doesn't know where it's on the screen, we can't pin the button to the bottom of it.
             Because of that the order of code matters.
             */

        ])
    }
    
    func configureResetButton() {
        view.addSubview(resetButton)
        
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 115),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.leadingAnchor.constraint(equalTo: stopButton.leadingAnchor), //pin it to the leading anchor of the stopButton. Line up the left sides of the buttons.
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    func configureRulesButton() {
        view.addSubview(rulesButton)
        
        //when we tap rulesButton, it's going to fire up presentRulesVC()
        rulesButton.addTarget(self, action: #selector(presentRulesVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.trailingAnchor.constraint(equalTo: stopButton.trailingAnchor), //pin it to the trailing anchor of the stopButton. Line up right sides of the buttons.
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func presentRulesVC() {
        /*
         presents the ViewController RulesVC(). Presenting is modally. Slides up from the bottom.
         If we were in a NavigationController, we wouldn't use present,
         we would use NavigationController.pushViewController(RulesVC(), animated: true)
         we're not passing any data.
         Presenting a brand new RulesVC
        */

        present(RulesVC(), animated: true)
    }

}
