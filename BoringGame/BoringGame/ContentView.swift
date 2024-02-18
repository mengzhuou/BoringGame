//
//  ContentView.swift
//  BoringGame
//
//  Created by Mengzhu Ou on 2/17/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var scene: SKScene{
        let scene = GameScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        
        return scene
    }
    
    var count = 0
    var body: some View {
        VStack{
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight, alignment: .center)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
