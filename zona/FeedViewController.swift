//
//  FeedViewController.swift
//  zona
//
//  Created by MacDouble on 2/20/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var nanas: [Nana] = []
    var ref: DatabaseReference!
    @IBOutlet var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nanas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: view.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customcell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellId", for: indexPath) as! CustomCell
        customcell.titleLabel.text = nanas[indexPath.row].title
        customcell.schoolLabel.text = nanas[indexPath.row].poster
        customcell.contentLabel.text = nanas[indexPath.row].content
        return customcell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCellId")
        navigationItem.title = "在哪"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "SourceHanSansSC-Bold", size: 20)!]
        
        let menuButton = UIButton.init(frame: CGRect(x: 16, y: 34, width: 16, height: 16))
        menuButton.setImage(UIImage.init(named: "align-left"), for: .normal)
        
        let postButton = UIBarButtonItem(image: UIImage.init(named: "edit"), style:.plain , target: self, action: #selector(addNanaAction))
        
        navigationItem.rightBarButtonItem = postButton
        self.view.addSubview(menuButton)
        readDataFromFireBase()
        
        // Do any additional setup after loading the view.
    }
    
    func readDataFromFireBase(){
        ref = Database.database().reference().child("nanas")
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            let nana = snapshot.value as? [String: Any]
            if let titleString = nana!["title"]! as? String{
     
                let localNana = Nana.init(profileImage: nana!["profileImage"]! as! String, title: nana!["title"]! as! String, content: nana!["content"]! as! String, poster: nana!["poster"]! as! String, cat: nana!["cat"]! as! String, addedBy: nana!["addedBy"]! as! String)
                self.nanas.append(localNana)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        })
        
        
    }
    
    @objc func addNanaAction(){
        self.performSegue(withIdentifier: "addNanaSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
      
        var realname = ""
        
        if (false/*Auth.auth().currentUser != nil*/){
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("users").child(uid!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print("getting value = ")
            print(value)
            
            realname = value!["name"] as! String
            print(realname)
            UserDefaults.standard.setValuesForKeys(["name": realname])
            
        })
        }
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

private class CustomCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    let schoolLabel: UILabel = {
        let templabel = UILabel()
        templabel.text = "test"
        templabel.font = UIFont(name: "SourceHanSansSC-Regular", size: 13)
        templabel.translatesAutoresizingMaskIntoConstraints = false
        return templabel
    }()
    
    
    let profileImage: UIImageView = {
        let tempImageView = UIImageView.init(image: #imageLiteral(resourceName: "profileImage"))
        //tempImageView.backgroundColor = UIColor.red
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        tempImageView.contentMode = UIViewContentMode.scaleAspectFit
        return tempImageView
    }()
    
    let catLabel: UILabel = {
        let templabel = UILabel()
        templabel.text = "闲聊"
        templabel.font = UIFont(name: "SourceHanSansSC-Light", size: 13)
        templabel.translatesAutoresizingMaskIntoConstraints = false
        return templabel
    }()
    
    let titleLabel: UILabel = {
        let templabel = UILabel()
        templabel.text = "小心！已经有人中毒！在Costco买的鱼里竟然有活虫"
        templabel.font = UIFont(name: "SourceHanSansSC-Bold", size: 16)
        templabel.translatesAutoresizingMaskIntoConstraints = false
        return templabel
    }()
    
    let contentLabel: UILabel = {
        let templabel = UILabel()
        templabel.text = "这只是一个测试用的信息，costco的热狗真的又便宜又好吃"
        templabel.font = UIFont(name: "SourceHanSansSC-Light", size: 14)
        templabel.translatesAutoresizingMaskIntoConstraints = false
        return templabel
    }()

    let cellBar: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.backgroundColor = UIColor.gray
        tempImageView.alpha = 0.3
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
    //tempImageView.contentMode = UIViewContentMode.scaleAspectFit
        return tempImageView
    }()
    
    func setupViews(){
       addSubview(schoolLabel)
       addSubview(profileImage)
       addSubview(catLabel)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(cellBar)
        
        
        
       //profileImage
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(36)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImage]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(36)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImage]))
       //schoolNameLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImage, "v1": schoolLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1(18)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": schoolLabel]))
       //catLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImage, "v1": catLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-0-[v1(18)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": schoolLabel, "v1": catLabel]))
        //titleLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-2-[v1(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImage, "v1": titleLabel]))
        //contentLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": contentLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-0-[v1(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel, "v1": contentLabel]))
        //bar
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[v0]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellBar]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1(1)]-1-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": cellBar]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
