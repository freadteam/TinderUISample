//
//  ViewController.swift
//  TinderUISample
//
//  Created by Ryo Endo on 2018/07/15.
//  Copyright © 2018年 Ryo Endo. All rights reserved.
//


//storyBoardにViewを置く
//viewのクラスとmodulを設定する

import UIKit
import Koloda

class ViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {
    
    @IBOutlet weak var kolodaView: KolodaView!
    var imageNameArray = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", ]
   //追加ーーーーーーーーーーーーーーーーーー
    var likedArray = [String]()
    var nopedArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //追加ーーーーーーーーーーーーーーーーーー
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! NextViewController
        nextViewController.passedNopedArray = nopedArray
        nextViewController.passedLikedArray = likedArray
        
        nopedArray.removeAll()
        likedArray.removeAll()
    }
    
    //枚数
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return imageNameArray.count
    }
    
    //ドラッグのスピード
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    //表示内容
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        //        let view = UIView(frame: koloda.bounds)
        //        view.backgroundColor = randomColor()
        //        return view
        let imageView = UIImageView(frame: koloda.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageNameArray[index])
        koloda.addSubview(imageView)
        imageView.backgroundColor = randomColor()
        return imageView
    }
    
    //カードの色を指定、今回はランダム
    func randomColor() -> UIColor {
        return UIColor(red: randomFloat(), green: randomFloat(), blue: randomFloat(), alpha: 1)
    }
    
    //ランダムに色を生成
    func randomFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    
    //delegate------------------
    
    // カードを全て消費したときの処理を定義する
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("Finish cards.")
        //シャッフル
        imageNameArray = imageNameArray.shuffled()
        //リスタート
        koloda.resetCurrentCardIndex()
    }
    
    //カードをタップした時に呼ばれる
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //urlに飛べる
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    //dragやめたら呼ばれる
    func kolodaDidResetCard(_ koloda: KolodaView) {
        print("reset")
    }
    
    //darag中に呼ばれる
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
        print(index, "drag")
        return true
    }
    
    //dtagの方向など
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        print(index, direction)
        //追加ーーーーーーーーーーーーーーーーーー
        switch direction {
        case .left:
            return nopedArray.append(imageNameArray[index])
        default:
            return likedArray.append(imageNameArray[index])
        }
    }
    
    //nopeへ
    @IBAction func cardGoToNope() {
        kolodaView.swipe(.left)
    }
    
    //likeへ
    @IBAction func cardGoToLike() {
        kolodaView.swipe(.right)
    }
    
}
