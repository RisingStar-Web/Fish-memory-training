//
//  LightButton.swift
//  Fish memory training
//
//  Created by Kuts, Andrey on 7/26/19.
//  Copyright © 2019 fish. All rights reserved.
//

import UIKit

class LightButton: UIButton {
    private let defaultBackgroundColor = UIColor.init(white: 0.98, alpha: 0.7)
    private let defaultSelectedColor = UIColor.init(red: 199/255, green: 200/255, blue: 198/255, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBeautifully()
    }
    
    func setBeautifully() {
        layer.cornerRadius = 12.0
        backgroundColor = defaultBackgroundColor
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.init(white: 1.0, alpha: 1.0).cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = defaultSelectedColor
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = defaultBackgroundColor
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = defaultBackgroundColor
        super.touchesCancelled(touches, with: event)
    }
    
}
