//
//  LoginViewController.swift
//  zona
//
//  Created by MacDouble on 2/21/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 204/255, green: 72/255, blue: 118/255, alpha: 1)
        tf1.frame = CGRect(x: 35, y: self.view.bounds.height*(271/736), width: self.view.bounds.width-70, height: self.view.bounds.height*(53/736))
        tf1.backgroundColor = UIColor.white
        tf1.layer.cornerRadius = 7
        tf2.frame = CGRect(x: 35, y: self.view.bounds.height*(332/736), width: self.view.bounds.width-70, height: self.view.bounds.height*(53/736))
        tf2.backgroundColor = UIColor.white
        tf2.layer.cornerRadius = 7
        
        let loginButton = UIButton.init(frame: CGRect(x: 35, y: self.view.bounds.height*(456/736), width: self.view.bounds.width-70, height: self.view.bounds.height*(53/736)))
        loginButton.setTitle("登陆", for: .normal)
        loginButton.titleLabel?.textAlignment = NSTextAlignment.center
        loginButton.titleLabel?.textColor = UIColor.white
        loginButton.layer.cornerRadius = 7
        loginButton.backgroundColor = UIColor.init(red: 217/255, green: 98/255, blue: 140/255, alpha: 1)
        loginButton.titleLabel?.font = UIFont(name: "SourceHanSansSC-Regular", size: 18)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        let signupButton = UIButton.init(frame: CGRect(x: 35, y: self.view.bounds.height*(509/736)+16, width: self.view.bounds.width-70, height: self.view.bounds.height*(40/736)))
        signupButton.setTitle("创建一个新的账号", for: .normal)
        signupButton.titleLabel?.textAlignment = NSTextAlignment.center
        signupButton.titleLabel?.textColor = UIColor.white
        signupButton.addTarget(self, action: #selector(performSignupSegue), for: .touchUpInside)
        signupButton.titleLabel?.font = UIFont(name: "SourceHanSansSC-Regular", size: 15)
        
        let cancelButton = UIButton.init(frame: CGRect(x: 16, y: 34, width: 16, height: 16))
        cancelButton.setImage(UIImage.init(named: "x"), for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        warningLabel.frame = CGRect(x: 35, y: self.view.bounds.height*(271/736)-10, width: self.view.bounds.width-70, height: 10)
        warningLabel.font = UIFont(name: "SourceHanSansSC-Regular", size: 12)
        warningLabel.textColor = UIColor.white
        
        
        
        self.view.addSubview(warningLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(tf1)
        self.view.addSubview(tf2)
        self.view.addSubview(signupButton)
        self.view.addSubview(cancelButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func loginAction(){
        if let username = tf1.text, let password = tf2.text{
            Auth.auth().signIn(withEmail: username, password: password, completion: {(user, error) in
                if let firebaseError = error{
                    self.warningLabel.text = (firebaseError.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "homeSegue", sender: self)
                
            })
        }
    }
    
    @objc func performSignupSegue(){
        self.performSegue(withIdentifier: "signupSegue", sender: self)
    }
    @objc func dismissViewController(){
        self.performSegue(withIdentifier: "homeSegue", sender: self)
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
