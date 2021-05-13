//
//  ViewController.swift
//  TouchNumber
//
//  Created by 内間理亜奈 on 2017/03/02.
//  Copyright © 2017年 riana. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation
import GameKit

class ViewController: UIViewController,GKGameCenterControllerDelegate {
    

//    var musicPlayer:AVAudioPlayer!
//    let se1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bathroom_sw1", ofType: "mp3")!)
//    let se2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "blip03", ofType: "mp3")!)
    

    
    
    let AdMobID = "ca-app-pub-9614012526549975/1549422848"
    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"
    
    let AdMobTest:Bool = false

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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func start(_ sender: Any) {
//        sound1()
    }
    
    
    
//    @IBAction func showLeaderbord(_ sender: Any) {
//        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
//        gcVC.gameCenterDelegate = self
//        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
//        gcVC.leaderboardIdentifier = "Tn\(stage)"
//        self.present(gcVC, animated: true, completion: nil)
//    }
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func Ranking(_ sender: Any) {
        
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
        gcVC.leaderboardIdentifier = "Tn3"
        self.present(gcVC, animated: true, completion: nil)
    }
    func authPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(view, error) in
            if view != nil{
                self.present(view!,animated: true, completion: nil)
            }else{
                print(GKLocalPlayer.localPlayer().isAuthenticated)
            }
        }
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
        // Dispose of any resources that can be recreated.
    }


}

