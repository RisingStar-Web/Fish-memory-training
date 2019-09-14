//
//  StartViewController.swift
//  Fish memory training
//
//  Created by Kuts, Andrey on 7/26/19.
//  Copyright © 2019 fish. All rights reserved.
//

import UIKit
import Foundation

class StartViewController: UIViewController {
    
    @IBOutlet weak var labelTopLevel: UILabel!
    @IBOutlet weak var labelTopScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTopScores()
        setLevels()
    }
    
    func setLevels() {

        Data.levels.removeAll()
        
        for i in 0...1000 {
            var level: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            
            var levelMin = Int(arc4random_uniform(UInt32(11)) + 6)
            if i == 0 {
                levelMin = 4
            }
            if i > 0 && i <= 3 {
                levelMin = 5
            }
            if i > 3 && i <= 6 {
                levelMin = 6
            }
            if i > 6 && i <= 8 {
                levelMin = 7
            }
            if i > 8 && i <= 10 {
                levelMin = 8
            }
            if i > 10 && i <= 12 {
                levelMin = 10
            }
            
            if levelMin > 12 {
                levelMin = 12
            }
            
            while getCount(level) < levelMin {
                let imgCode = Int(arc4random_uniform(UInt32(63)) + 1)
                
                var index1 = Int(arc4random_uniform(UInt32(11)) + 0)
                var index2 = Int(arc4random_uniform(UInt32(11)) + 0)
                while index1 == index2 {
                    index2 = Int(arc4random_uniform(UInt32(11)) + 0)
                }
                var b = true
                while b {
                    b = false
                    if level[index1] != 0 {
                        for i in 0..<level.count {
                            if (level[i] == 0) && (index2 != i) {
                                index1 = i
                                break
                            }
                        }
                        /*
                         index1 = Int(arc4random_uniform(UInt32(11)) + 0)
                         while (index1 == index2) && (level[index1] != 0) {
                         index1 = Int(arc4random_uniform(UInt32(11)) + 0)
                         }
                         */
                        b = true
                        continue
                    }
                    if level[index2] != 0 {
                        for i in 0..<level.count {
                            if (level[i] == 0) && (index1 != i) {
                                index2 = i
                                break
                            }
                        }
                        /*
                         index2 = Int(arc4random_uniform(UInt32(11)) + 0)
                         while (index1 == index2) && (level[index2] != 0) {
                         index2 = Int(arc4random_uniform(UInt32(11)) + 0)
                         }
                         */
                        b = true
                        continue
                    }
                }
                level[index1] = imgCode
                level[index2] = imgCode
            }
            
            print("\(getCount(level))")
            
            Data.levels.append(level)
        }
        
    }
    
    func getCount(_ array: [Int]) -> Int {
        var cnt = 0
        for i in array {
            if i != 0 {
                cnt += 1
            }
        }
        return cnt
    }
    
    
    func setupTopScores() {
        let topScore = UserDefaults.standard.integer(forKey: "topScore")
        let topLevel = UserDefaults.standard.integer(forKey: "topLevel")
        labelTopLevel.text = "Top level:".localized + " \(topLevel)"
        labelTopScore.text = "Top score:".localized + " \(topScore)"
    }
    
    @IBAction func buttonResetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset top scores".localized, message: "Do you really want to reset top scores?".localized, preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes".localized, style: .destructive, handler: { (_) in
            UserDefaults.standard.set(0, forKey: "topScore")
            UserDefaults.standard.set(0, forKey: "topLevel")
            self.setupTopScores()
        })
        
        let no = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        
        alert.addAction(yes)
        alert.addAction(no)
        
        present(alert, animated: true, completion: nil)
    }
}

