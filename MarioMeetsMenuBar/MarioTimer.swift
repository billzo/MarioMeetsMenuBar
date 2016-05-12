//
//  MarioTimer.swift
//  MarioMeetsMenuBar
//
//  Created by billzo on 5/11/16.
//  Copyright © 2016 SwiftBlog. All rights reserved.
//

import Foundation

class MarioTimer {
    var timer = NSTimer()
    
    var marioController: MarioWindowController!
    
    init (marioController: MarioWindowController) {
        self.marioController = marioController
    }
    
    func startTimer(translationDuration: Double) {
        timer = NSTimer.scheduledTimerWithTimeInterval(translationDuration, target: self, selector: #selector(MarioTimer.timerTick), userInfo: nil, repeats: true)
    }
    
    dynamic func timerTick() {
        marioController.animateMario()
    }
    
    func restart(translationDuration: Double) {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(translationDuration, target: self, selector: #selector(MarioTimer.timerTick), userInfo: nil, repeats: true)
    }
}