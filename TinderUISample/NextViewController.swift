//
//  NextViewController.swift
//  TinderUISample
//
//  Created by Ryo Endo on 2018/09/30.
//  Copyright © 2018 Ryo Endo. All rights reserved.
//
//追加ーーーーーーーーーーーーーーーーーー
import UIKit

class NextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var displayArray = [String]()
    var passedNopedArray = [String]()
    var passedLikedArray = [String]()
    var isLiked = true
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        switch isLiked {
        case false:
            navigationItem.title = "Nope"
            return displayArray = passedNopedArray
        default:
            navigationItem.title = "Like"
            return displayArray = passedLikedArray
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //imageViewとセルの結びつけ
        let imageView = cell.viewWithTag(9) as! UIImageView
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: displayArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 364
    }
    
    @IBAction func switchDisplayContent() {
        isLiked = !isLiked
        if isLiked == false {
            navigationItem.title = "Nope"
            displayArray = passedNopedArray
        } else {
            navigationItem.title = "Like"
            displayArray = passedLikedArray
        }
        tableView.reloadData()
    }
    
    
}
