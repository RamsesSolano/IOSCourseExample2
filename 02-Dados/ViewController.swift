//
//  ViewController.swift
//  02-Dados
//
//  Created by Ramses Solano Ramirez on 28/09/18.
//  Copyright © 2018 Emk Soft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewDiceLeft: UIImageView!
    @IBOutlet weak var imageViewDiceRight: UIImageView!
    @IBOutlet weak var totalValueDicesLabel: UILabel!
    
    var randomDiceIndexLeft: Int
    var randomDiceIndexRight: Int
    let diceImages: [String]
    let nfaces: UInt32
    
    required init?(coder aDecoder: NSCoder) {
        self.randomDiceIndexRight = 0
        self.randomDiceIndexLeft = 0
        self.diceImages = [  // let indicate constans in swift, is important remember
            "dice1",
            "dice2",
            "dice 3",
            "dice4",
            "dice5",
            "dice6"
        ]
        self.nfaces = UInt32( diceImages.count )
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateRandomDices()
    }

    @IBAction func rollPressed(_ sender: UIButton) {
        generateRandomDices()
    }
    
    func generateRandomDices(){
        self.randomDiceIndexLeft = Int(arc4random_uniform(self.nfaces))
        self.randomDiceIndexRight = Int(arc4random_uniform(self.nfaces))
        
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: -100, y: 100))
                
                self.imageViewDiceRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: 100, y: 100))
                
                self.imageViewDiceRight.alpha = 0.0
                self.imageViewDiceLeft.alpha = 0.0
                
        }) { (completed) in
            
            self.imageViewDiceRight.transform = CGAffineTransform.identity
            self.imageViewDiceLeft.transform = CGAffineTransform.identity
            
            self.imageViewDiceRight.alpha = 1.0
            self.imageViewDiceLeft.alpha = 1.0
            
            self.imageViewDiceLeft.image = UIImage( named: self.diceImages[self.randomDiceIndexLeft] )
            self.imageViewDiceRight.image = UIImage( named: self.diceImages[self.randomDiceIndexRight] )
        
            self.totalValueDicesLabel.text = "Tienes " + String( (self.randomDiceIndexLeft+1) + (self.randomDiceIndexRight+1) )
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if( motion == .motionShake ){
            self.generateRandomDices()
        }
    }
}

