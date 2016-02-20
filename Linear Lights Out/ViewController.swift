//
//  ViewController.swift
//  Linear Lights Out
//
//  Created by Ishank Tandon on 1/9/15.
//  Copyright (c) 2015 Ishank Tandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var turns = 0;

    var game = LinearLightsOutGame(numLights: 13)
    
    @IBOutlet var GameBoardButtons: [UIButton]!
    @IBOutlet weak var TurnLabel: UILabel!
    
    @IBAction func pressedNewGame(sender: AnyObject) {
        game = LinearLightsOutGame(numLights: 13)
        turns = 0
        updateView()
    }
    
   // @IBOutlet weak var gameBoardImageView: UIImageView!
    
    
    @IBOutlet weak var gameStateNavBar: UINavigationBar!
    
    @IBAction func pressedGameBoardButton(sender: AnyObject) {
        var button = sender as! UIButton
        
        game.pressedLightAtIndex(button.tag)
        if game.gameState == .playing {
        turns++
        }
        updateView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameStateNavBar.titleTextAttributes=[NSFontAttributeName: UIFont.boldSystemFontOfSize(20)]
        
        updateView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(){
        if (game.gameState == .win){
            if UIDevice.currentDevice().userInterfaceIdiom == .Phone{
                TurnLabel.text = "you won in \(String(turns)) turns"
            }
            else{
                gameStateNavBar.topItem?.title =  "you won in \(String(turns)) tries"
            }
        }else{
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone{
            TurnLabel.text = "you have tried \(String(turns)) times"
        }
        else{
            gameStateNavBar.topItem?.title =  "you have tried \(String(turns)) times"
        }
        }
        
        for button in GameBoardButtons{
            if game.lightStates[button.tag] {
                button.setBackgroundImage(UIImage(named: "light_on.png"), forState: UIControlState.Normal)
            }
            else{
                
                button.setBackgroundImage(UIImage(named: "light_off.png"), forState: UIControlState.Normal)
                
            }
        }
        
        }
    }



