//
//  AddNanaViewController.swift
//  zona
//
//  Created by MacDouble on 2/22/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class AddNanaViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tf2: UITextField!
    var poster: String = ""
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textview.delegate = self
        
        let naviImageView = UIImageView.init()
        naviImageView.backgroundColor = UIColor.init(red: 204/255, green: 72/255, blue: 118/255, alpha: 1)
        naviImageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64)
        cancelButton.frame = CGRect(x: 16, y: 34, width: 16, height: 16)
        tf1.frame = CGRect(x: 0, y: 64 , width: self.view.bounds.width, height: 64)
        tf1.font = UIFont(name: "SourceHanSansSC-Bold", size: 19)
        tf1.placeholder = "请输入标题"
       /* tf2.frame = CGRect(x: 0, y: 128 , width: self.view.bounds.width, height: self.view.bounds.height/2)
        tf2.font = UIFont(name: "SourceHanSansSC-Regular", size: 15)
        tf2.placeholder = "请输入文章内容"
        tf2.textAlignment = NSTextAlignment.left
           */
        textview.frame = CGRect(x: 0, y: 128 , width: self.view.bounds.width, height: self.view.bounds.height/2)
       textview.font = UIFont(name: "SourceHanSansSC-Regular", size: 15)
        textview.text = "请输入您的文章"
        
        textview.textColor = UIColor.init(red: 199/255, green: 199/255, blue: 205/255, alpha: 1)
        
       textview.contentInset = UIEdgeInsetsMake(0, 4, 0, 4)
       
        let postButton = UIButton.init(frame: CGRect(x:self.view.bounds.width-32 , y: 34, width: 16, height: 16))
        postButton.setImage(UIImage.init(named: "check"), for: .normal)
        postButton.addTarget(self, action: #selector(addNanaAction), for: .touchUpInside)
        self.view.addSubview(naviImageView)
        
            self.view.addSubview(postButton)
        self.view.addSubview(cancelButton)
        
        // Do any additional setup after loading the view.
        ref=Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let tempUser = snapshot.value as? [String: Any]{
                self.poster = tempUser["name"]! as! String
            }
            
            
        })
    }
    
    
    @objc func addNanaAction(){
        if tf1.text != nil{
            if (textview.text.count >= 15){
                
               
                
                ref = Database.database().reference().child("nanas").child(tf1.text!)
                let newNana = Nana(profileImage: "1", title: tf1.text!, content: textview.text!, poster: self.poster, cat: "闲聊", addedBy: (Auth.auth().currentUser?.uid)!)
                ref.setValue(newNana.toAnyObject())
            }
        }
        self.performSegue(withIdentifier: "postedSegue", sender: self)

    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textView.text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "请输入您的文章"
            textView.textColor = UIColor.lightGray
        }
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
