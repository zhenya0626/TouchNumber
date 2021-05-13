//
//  ResultViewController.swift
//  TouchNumber
//
//  Created by 内間理亜奈 on 2017/03/02.
//  Copyright © 2017年 riana. All rights reserved.
//

import Foundation
import AVFoundation
import GoogleMobileAds
import UIKit
import GameKit

class ResultViewController: UIViewController, UIAlertViewDelegate, GADInterstitialDelegate, GKGameCenterControllerDelegate{
    var interstitial: GADInterstitial!
    
    let AdMobID = "ca-app-pub-9614012526549975/1549422848"
    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"
    
    let AdMobTest:Bool = false
    
    let userDefaults = UserDefaults.standard
    
    
    let label = UILabel()
    let bestlabel = UILabel()
    
    var time = 0.00
    var BestTime = 0.00
    
    var settingKey = ""
     var stage = 0
    var count = 0
    
    
//    var musicPlayer:AVAudioPlayer!
//    let se1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bathroom_sw1", ofType: "mp3")!)
//    let se2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "blip03", ofType: "mp3")!)
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stage = userDefaults.integer(forKey: "Key")
        settingKey = "timer_value\(stage)"
   
        let settings = UserDefaults.standard
        time = settings.double(forKey: settingKey)
        
        let bestsettings = UserDefaults.standard
        BestTime = bestsettings.double(forKey: "BestTime\(stage)")

            interstitial = createAndLoadInterstitial()
            endGame()

        
        authPlayer()
        if BestTime == 0.0{
            bestsettings.set(time, forKey: "BestTime\(stage)")
            BestTime = time
        }
        else if BestTime > time{
            bestsettings.set(time, forKey: "BestTime\(stage)")
            BestTime = time
            reportScore(value: Int64(BestTime*10), leaderboardId: "Tn\(stage)")
            
//            showLeaderbord()
        }
    
        let screenWidth:CGFloat = self.view.frame.width;
        let screenHeight:CGFloat = self.view.frame.height;
        //  let PlayWid = screenWidth/8*7
        let PlayHei = screenHeight/4*3
        
        label.text = "Score:  \(floor(10*time)/10)"
        label.textColor = UIColor.white
        label.sizeToFit()
        label.frame = CGRect(x:0, y:10, width:screenWidth, height:PlayHei/4)
        label.font = UIFont(name: "HiraMinProN-W3", size: 40)
        label.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(label)
        
        
        bestlabel.text = "High score:  \(floor(10*BestTime)/10)"
        bestlabel.textColor = UIColor.white
        bestlabel.sizeToFit()
        bestlabel.frame = CGRect(x:0, y:80, width:screenWidth, height:PlayHei/4)
        bestlabel.font = UIFont(name: "HiraMinProN-W3", size: 30)
        bestlabel.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(bestlabel)
 
        
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

    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-9614012526549975/4502889244")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    
    
    fileprivate func endGame() {
        UIAlertView(title: "Clear!!",
                    message: "your score is \(floor(10*time)/10)",
                    delegate: self,
                    cancelButtonTitle: "Ok").show()
    }
    
    func alertView(_ alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        count = userDefaults.integer(forKey: "count")
        if count%3==0{
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
        count = count + 1
        userDefaults.set(count, forKey: "count")
        // Give user the option to start the next game.
    }
    
    @IBAction func retry(_ sender: Any) {
        sound1()
    }
    
    @IBAction func menu(_ sender: Any) {
        sound1()
    }
    
    func sound1(){
        
        musicPlayer = try! AVAudioPlayer(contentsOf: se1 as URL)
        
        musicPlayer.play()
        
    }
    
    
    func reportScore(value: Int64, leaderboardId: String) {
        
        if GKLocalPlayer.localPlayer().isAuthenticated{
            let scoreReporter = GKScore(leaderboardIdentifier: leaderboardId)
            scoreReporter.value = Int64(value)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray,withCompletionHandler: nil)
        }

    }
    
    @IBAction func showLeaderbord(_ sender: Any) {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
        gcVC.leaderboardIdentifier = "Tn\(stage)"
        self.present(gcVC, animated: true, completion: nil)
    }

    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

