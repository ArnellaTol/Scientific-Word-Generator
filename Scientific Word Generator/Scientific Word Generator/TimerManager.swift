//
//  TimerManager.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 18.09.2022.
//  Copyright © 2022 arnella. All rights reserved.
//

import Foundation
import SwiftUI

class StopWatchManager: ObservableObject{
    @Published var secElapsed = 0.0
    var timer = Timer()
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){timer in
            self.secElapsed += 0.1
        }
    }
    
    func stop(){
        timer.invalidate()
        secElapsed = 0
    }
}
