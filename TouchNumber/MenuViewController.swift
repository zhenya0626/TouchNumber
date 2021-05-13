//
//  MenuController.swift
//  TouchNumber
//
//  Created by 内間理亜奈 on 2017/03/02.
//  Copyright © 2017年 riana. All rights reserved.
//

import Foundation
import GoogleMobileAds
import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
//    var musicPlayer:AVAudioPlayer!
//    let se1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bathroom_sw1", ofType: "mp3")!)
//    let se2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "blip03", ofType: "mp3")!)
//    

    
    
    let AdMobID = "ca-app-pub-9614012526549975/1549422848"
    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"
    
    let AdMobTest:Bool = false
    
    var stage = 0
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        var admobView = GADBannerView()
        
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - admobView.frame.height)
        admobView.frame.size = CGSize(width:self.view.frame.width, height:admobView.frame.height)
        
        if AdMobTest {
            admobView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        }
        else{
            admobView.adUnitID = AdMobID
        }
        
        admobView.rootViewController = self
        admobView.load(GADRequest())
        
        self.view.addSubview(admobView)
        
        
   
    }
    
    
    
    @IBAction func button9(_ sender: Any) {
//        sound1()
        stage = 3
        userDefaults.set(stage, forKey: "Key")
    }
    
    @IBAction func button25(_ sender: Any) {
//        sound1()
        stage = 5
        userDefaults.set(stage, forKey: "Key")
    }
    
    
    @IBAction func button49(_ sender: Any) {
//        sound1()
        stage = 7
        userDefaults.set(stage, forKey: "Key")
    }
    
    @IBAction func button100(_ sender: Any) {
//        sound1()
        stage = 10
        userDefaults.set(stage, forKey: "Key")
    }
    
    @IBAction func back(_ sender: Any) {
//        sound1()
    }
    
//    func sound1(){
//        
//        musicPlayer = try! AVAudioPlayer(contentsOf: se1 as URL)
//        
//        musicPlayer.play()
//        
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
}

