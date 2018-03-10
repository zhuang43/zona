//
//  NextSignupTableViewController.swift
//  zona
//
//  Created by MacDouble on 2/22/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class NextSignupTableViewController: UITableViewController {

    var ref : DatabaseReference!
    
    @IBOutlet var realnameTf: TextField!
    @IBOutlet var schoolTf: TextField!
    @IBOutlet var aboutTf: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        setupBorder(view: realnameTf)
        setupBorder(view: schoolTf)
        setupBorder(view: aboutTf)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    @IBOutlet var doneSignupbutton: UIButton!
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func doneSignup(_ sender: Any) {
        ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        let newUser = user(email:(Auth.auth().currentUser?.email)!, name: realnameTf.text!, school: schoolTf.text!, bio: aboutTf.text!)
        ref.setValue(newUser.toAnyObject())
        self.performSegue(withIdentifier: "signupDoneSegue", sender: self)
    }
    
    func setupBorder(view: UIView){
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.4).cgColor
        view.layer.borderWidth = 1
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
