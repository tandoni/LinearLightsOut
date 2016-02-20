//
//  LinearLightsOut.swift
//  Linear Lights Out
//
//  Created by Ishank Tandon on 1/9/15.
//  Copyright (c) 2015 Ishank Tandon. All rights reserved.
//

import Foundation
import UIKit


class LinearLightsOutGame : CustomStringConvertible {
    var lightStates : [Bool]
    
    
    var description : String {
        return "Lights: \(self.getGameString())"
    }
    
    enum GameState : String{
        case win = "win"
        case playing = "playing"
    }
    
    var gameState : GameState
    var moves : Int
    
    
    init(numLights : Int){
        self.lightStates = [Bool](count: numLights,repeatedValue: true)
        self.gameState = .playing
        self.moves = 0
        
            for k in 0..<numLights {
                let rands = arc4random_uniform(2)
                if (rands == 1) {
                    self.pressedLightAtIndex(k)
                }
            }
        self.moves = 0
        
    }
    
    func getGameString(indices :[Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12]) -> String {
        var gameString = "";
        for index in indices {
            if(lightStates[index]){
                gameString+="1"
            }
            else{
                gameString+="0"
            }
        }
        gameString += " moves: \(moves))"
        return gameString
    }
    
    func pressedLightAtIndex(index : Int)->String {
        if gameState == .win {
            return "true"
        }
        var lights = [Int]()
        if(index==0){
            lights.append(0)
            lights.append(1)
        }
        else if(index==self.lightStates.count-1){
            lights.append(self.lightStates.count-1)
            lights.append(self.lightStates.count-2)
        }
        else{
            lights.append(index)
            lights.append(index-1)
            lights.append(index+1)
        }
        self.moves++
        for index in lights{
            self.lightStates[index] = !self.lightStates[index]
        }
        if checkWin() {
            gameState = .win
            return "true"
        }
        else{
            return "false"
        }
    }
    
    func checkWin()-> Bool{
        var temp = true
        for light in lightStates {
            if light {
                temp = false
            }
        }
        return temp
    }
}
