//
//  GalleryViewController.swift
//  Fish memory training
//
//  Created by Kuts, Andrey on 7/26/19.
//  Copyright © 2019 fish. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var innnerView: UIView?
    var bigImage: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToBack))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(swipe)
        
        setupScene()
    }
    
    @objc func swipeToBack(sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupScene() {
        innnerView?.removeFromSuperview()
        
        innnerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height - 32))
        innnerView?.backgroundColor = UIColor.clear
        let cardSize: CGFloat = ((innnerView?.frame.width)! / 3) - 11
        var index = 1
        let totalRowsCount = 22
        
        for row in 0..<totalRowsCount {
            for col in 0..<3 {
                let x = (CGFloat(col) * cardSize) + CGFloat(col * 16)
                let y = (CGFloat(row) * cardSize) + CGFloat(row * 16)
                let rootFlipView = CardViewSecond(frame: CGRect(x: x, y: y, width: cardSize, height: cardSize))
                var imgName = "card-question"
                rootFlipView.imgName = ""
                let img2Name = "img\(index)"
                if let _ = UserDefaults.standard.object(forKey: "opened-\(img2Name)") {
                    imgName = img2Name
                    rootFlipView.imgName = img2Name
                }
                
                if index >= 64 {
                    break
                }
                
                let cardBack = initViewCard(0, 0, cardSize, imgName)
                let tap = UITapGestureRecognizer(target: self, action: #selector(cardPressed))
                rootFlipView.isUserInteractionEnabled = true
                rootFlipView.addGestureRecognizer(tap)
                rootFlipView.addSubview(cardBack)
                innnerView?.addSubview(rootFlipView)
                index += 1
            }
        }
        
        scrollView.contentInset.bottom = (cardSize * CGFloat(totalRowsCount)) + (16 * CGFloat(totalRowsCount))
        scrollView.addSubview(innnerView!)
        innnerView?.frame = CGRect(x: 0, y: 0, width: view.frame.width,
                                   height: view.frame.height + scrollView.contentInset.bottom)
    }
    
    @objc func saveCard(sender: UITapGestureRecognizer) {
        let v = sender.view as! CardViewSecond
        if v.imgName == "" { return }
        let image = UIImage(named: v.imgName!)
        // set up activity view controller
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func initViewCard(_ x: CGFloat, _ y: CGFloat, _ size: CGFloat, _ imgName: String) -> UIImageView {
        let frame = CGRect(x: x, y: y, width: size, height: size)
        let card = UIImageView(frame: frame)
        card.image = UIImage(named: imgName)
        card.layer.masksToBounds = true
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.white.cgColor
        card.layer.cornerRadius = 8
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 1, height: 1)
        card.layer.shadowRadius = 3.0
        card.layer.shadowOpacity = 0.75
        
        return card
    }
    
    
    @objc func cardPressed(sender: UITapGestureRecognizer) {
        if bigImage != nil {
            bigImage?.removeFromSuperview()
            bigImage = nil
            return
        }
        
        let v = sender.view as! CardViewSecond
        if v.imgName == "" { return }
        
        let frame = CGRect(x: 10, y: (view.frame.height / 2) - (view.frame.width / 2), width: view.frame.width - 20, height: view.frame.width - 20)

        bigImage = UIImageView(frame: frame)
        bigImage?.image = UIImage(named: v.imgName!)
        bigImage?.layer.masksToBounds = true
        bigImage?.layer.borderWidth = 2
        bigImage?.layer.borderColor = UIColor.white.cgColor
        bigImage?.layer.cornerRadius = 8
        bigImage?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigPressed))
        bigImage?.isUserInteractionEnabled = true
        bigImage?.addGestureRecognizer(tap)
        view.addSubview(bigImage!)
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.bigImage?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    @objc func bigPressed(sender: UITapGestureRecognizer) {
        let image = bigImage?.image
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
}
