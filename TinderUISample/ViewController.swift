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

    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        //シャッフル
        imageNameArray = shuffle(array: imageNameArray)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        imageNameArray = shuffle(array: imageNameArray)
        //リスタート
        koloda.resetCurrentCardIndex()
    }
    
    //カードをタップした時に呼ばれる
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
       //urlに飛べる
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        print(index)
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
    }
    
    //シャッフル
    func shuffle(array: [String]) -> [String] {
        var array = array
        var shuffledArray: [String] = []
        for _ in 0..<array.count {
            let index = Int(arc4random_uniform(UInt32(array.count)))
            shuffledArray.append(array[index])
            array.remove(at: index)
        }
        return shuffledArray
    }
    
    
    //左へ
    @IBAction func cardGoToleft() {
    kolodaView.swipe(.left)
    }
    
    //右へ
    @IBAction func cardGoToright() {
        kolodaView.swipe(.right)
    }

}

