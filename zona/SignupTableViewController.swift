//
//  SignupTableViewController.swift
//  
//
//  Created by MacDouble on 2/21/18.
//

import UIKit
import Firebase

class SignupTableViewController: UITableViewController {
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var confirmTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
        cancelButton.frame = CGRect(x: 16, y: 34, width: 16, height: 16)
        
        self.view.addSubview(cancelButton)
        setupBorder(view: usernameTf)
        setupBorder(view: passwordTf)
        setupBorder(view: confirmTf)

        
        completeButton.layer.cornerRadius = 7
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeButton(_ sender: Any) {
        if let username = usernameTf.text{
            if username == ""{
                warningLabel.text = "请填写您的学校邮箱"
                return
            }
            let index = username.index(username.endIndex, offsetBy: -4)
            
            let range = index...
            
            if username[range] == "edu"{
                warningLabel.text = "请使用您所在学校的邮箱"
                return
            }
        }else{
            warningLabel.text = "请填写您的学校邮箱"
            return
        }
        
        if let password = passwordTf.text{
            if password.count < 8{
                "您的密码需要大于八位，请使用数字和英文字母的组合"
                return
            }
        }else{
            warningLabel.text = "请输入您的密码"
            return
        }
        
        if let confirm = confirmTf.text{
            if passwordTf.text != confirm{
                "请确认您两次输入的密码一致"
                return
            }
            
        }else{
            warningLabel.text = "请确认您两次输入的密码一致"
            return
        }
        if let username = usernameTf.text, let password = passwordTf.text{
            Auth.auth().createUser(withEmail: username, password: password, completion: {(user, error) in
                if let firebaseError = error{
                    self.warningLabel.text = (firebaseError.localizedDescription)
                    return
                }
                
            })
        }
        self.performSegue(withIdentifier: "nextSignup", sender: self)
        
    }
    @objc func dissmissKeyboard(){
        
        view.endEditing(true)
        UIView.animate(withDuration: 0.25, animations: {
            self.setupBorder(view: self.passwordTf)
            self.setupBorder(view: self.confirmTf)
            self.setupBorder(view: self.usernameTf)
        })
    }

    func setupBorder(view: UIView){
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.4).cgColor
        view.layer.borderWidth = 1
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
