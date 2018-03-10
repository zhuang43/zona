//
//  MessageViewController.swift
//  zona
//
//  Created by MacDouble on 2/21/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let naviImageView = UIImageView.init()
        naviImageView.backgroundColor = UIColor.init(red: 204/255, green: 72/255, blue: 118/255, alpha: 1)
        naviImageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64)
        self.view.addSubview(naviImageView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
