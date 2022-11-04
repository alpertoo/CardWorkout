//
//  CWButton.swift
//  CardWorkoutProgrammatic
//
//  Created by Alper Koçer on 3.11.2022.
//

import UIKit

class CWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // configure()
       
        /*
         overrides the UIButton init, because we want to call configure(), we want to add our own special configurations.
         Whenever we initialize a CWButton, we're going to get all the normal UIButton initialization (super.init()),
         by overriding it in the subclass, we add our orn special styling.
         */
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        // all subclasses have to have this
    }
    
    init(color: UIColor, title: String, systemImageName: String) {
        super.init(frame: .zero)
        
        //IOS15 Buttons
        configuration = .tinted()
        configuration?.title = title
        configuration?.baseForegroundColor = color
        configuration?.baseBackgroundColor = color
        configuration?.cornerStyle = .medium
        
        //IOS15 Button Images
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 5
        configuration?.imagePlacement = .leading
        
        translatesAutoresizingMaskIntoConstraints = false //use AutoLayout
        /*
         --- OLD BUTTONS ---
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
         */
    }
    
    /*
     --- OLD BUTTONS ---
    func configure() {
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false //use AutoLayout
    }
     */

}
