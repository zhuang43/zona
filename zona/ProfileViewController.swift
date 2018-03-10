//
//  ProfileViewController.swift
//  zona
//
//  Created by MacDouble on 2/20/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController{


    let bar1View = UIImageView.init()
    var nameLabel = UILabel()
    var schoolLabel = UILabel()
    var bioLabel = UILabel()
    
    @IBOutlet var bgView: UIImageView!

    var ref = DatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bgView.backgroundColor = UIColor.init(red: 204/255, green: 72/255, blue: 118/255, alpha: 1)
       // bgView.frame = CGRect(x: 0, y:0, width: self.view.bounds.width, height: self.view.bounds.height*(1-0.618)-20)
        
        let piView = UIImageView.init(image: #imageLiteral(resourceName: "profileImage"))
        piView.backgroundColor = UIColor.white
        piView.layer.borderColor = UIColor.white.cgColor
        piView.layer.cornerRadius = 30
        piView.layer.borderWidth = 3
        piView.frame = CGRect(x: 12, y: 50, width: 60, height: 60)
        
       nameLabel = UILabel(frame: CGRect(x: 80, y: 50, width: 200, height: 30))
        nameLabel.textAlignment = NSTextAlignment.left
        
        nameLabel.font = UIFont(name: "SourceHanSansSC-Bold", size: 23)
        nameLabel.textColor = UIColor.white
        
        schoolLabel = UILabel(frame: CGRect(x: 80, y: 80, width: 200, height: 30))
        schoolLabel.textAlignment = NSTextAlignment.left
        schoolLabel.text = ""
        schoolLabel.font = UIFont(name: "SourceHanSansSC-Regular", size: 15)
        schoolLabel.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        bioLabel = UILabel(frame: CGRect(x: 12, y: 110, width: self.view.frame.width-12, height: 30))
        bioLabel.textAlignment = NSTextAlignment.left
        bioLabel.text = ""
        bioLabel.font = UIFont(name: "SourceHanSansSC-Medium", size: 15)
        bioLabel.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
   
        self.view.addSubview(bgView)
        //bgView
        bgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bgView]))
 self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(150)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bgView]))
       
        self.view.addSubview(piView)

        self.view.addSubview(nameLabel)
        self.view.addSubview(schoolLabel)
       // self.view.addSubview(likedPostsButton)
       // self.view.addSubview(myPostsButton)
        self.view.addSubview(bar1View)
        self.view.addSubview(bioLabel)
        
        
        
 
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var signoutButton: UIButton!
    @IBAction func signoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    @objc func setupButton(sender: UIButton!){
        UIView.animate(withDuration: 0.25, animations: {
            
        let n = sender.tag
        let width = self.view.bounds.width
        self.bar1View.frame = CGRect(x: (70+CGFloat(n)*width/2), y: self.view.bounds.height*(1-0.618)+15, width: self.view.bounds.width/2-140, height: 2)
        self.bar1View.backgroundColor = UIColor.white
        self.view.addSubview(self.bar1View)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil{
        self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users").child(uid!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.nameLabel.text = value!["name"] as? String
            self.bioLabel.text = value!["bio"] as? String
            self.schoolLabel.text = value!["school"] as? String

        })
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

