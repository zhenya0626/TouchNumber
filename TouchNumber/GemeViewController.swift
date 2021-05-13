//
//  GemeViewController.swift
//  TouchNumber
//
//  Created by 内間理亜奈 on 2017/03/02.
//  Copyright © 2017年 riana. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import AVFoundation

class GameViewController: UIViewController {
    
     let userDefaults = UserDefaults.standard
    var stage = 0
    var count = 0
    var Hspace = 0
    let label = UILabel()
    let scorelabel = UILabel()
    var time=0.0;
//    var musicPlayer:AVAudioPlayer!
//    let se1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bathroom_sw1", ofType: "mp3")!)
//    let se2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "blip03", ofType: "mp3")!)
//    

    
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
        
        
        
        stage = userDefaults.integer(forKey: "Key")
        var booleanArray=[Bool](repeating:false, count:stage*stage)
        
        let screenWidth:CGFloat = self.view.frame.width;
        let screenHeight:CGFloat = self.view.frame.height;
       
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(GameViewController.TimerEvent), userInfo: nil,repeats: true)
        
        
        
        for i in 0..<stage*stage {
            let button = UIButton()
            button.frame = CGRect(x:(screenWidth*CGFloat(i/stage))/CGFloat(stage), y:(screenHeight-screenWidth)/2+(screenWidth*CGFloat(i%stage))/CGFloat(stage), width:screenWidth/CGFloat(stage), height:screenWidth/CGFloat(stage))
            
            
        
            var num = 0
            repeat {
                num = Int(arc4random_uniform(UInt32(stage*stage)))
            } while booleanArray[num]
            booleanArray[num] = true
            button.setTitle("\(num+1)", for: .normal)
//            button.backgroundColor = UIColor.green // ボタンの背景色を赤に
//            button.setTitleColor(UIColor.blue, for: .normal)
            button.setImage(UIImage(named: "\(num+1).png"), for: .normal)
            button.addTarget(self, action: #selector(buttonEvent(sender: )), for: .touchUpInside)
            button.tag=Int(num)
            self.view.addSubview(button)
            
            
            label.text = "1"
            label.textColor = UIColor.white
            label.sizeToFit()
            label.frame = CGRect(x:0, y:(screenHeight-screenWidth)/4, width:screenWidth, height:50)
            label.font = UIFont(name: "HiraMinProN-W3", size: 30)
            label.textAlignment = NSTextAlignment.center
            
            self.view.addSubview(label)
           
            
            scorelabel.text = "0"
            scorelabel.textColor = UIColor.white
            scorelabel.sizeToFit()
            scorelabel.frame = CGRect(x:15, y:(screenHeight-screenWidth)/4, width:100, height:50)
            scorelabel.font = UIFont(name: "HiraMinProN-W3", size: 20)
            self.view.addSubview(scorelabel)

        }
        
    }
    
    func buttonEvent(sender: UIButton) {
        if count==sender.tag{
            
            sender.alpha = 0 // 非表示に設定
            count+=1
            
            label.text = "\(count+1)"
            
            if count == (stage*stage){
                result()
            }else{
         
//                
            
//            sound1()
    
            }
        }else{
            
            
//            sound2()
        }
        
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
//    func sound2(){
//
//        musicPlayer = try! AVAudioPlayer(contentsOf: se2 as URL)
//        musicPlayer.volume=0.3
//        musicPlayer.play()
//
//    }
    func TimerEvent(){//タイマー実行関数
        if count < stage*stage {
            
            time += 0.1
            // print("timer event")
            scorelabel.text = "\(floor(10*time)/10)"
        }
    }

    func result(){
        //  print("clear!")
        let settings = UserDefaults.standard
        settings.register(defaults: ["timer_value\(stage)":time])
     
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "ResultViewController")
        self.present(nextView, animated: true, completion: nil)
        
        
    
    }
//}
//    func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
}

