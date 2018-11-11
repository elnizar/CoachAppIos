//
//  NewMessageViewController.swift
//  coachApp
//
//  Created by ESPRIT on 25/04/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Firebase
class NewMessageViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var users = [User]()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //let speciality: Speciality = Speciality(id: 0, name: "", domain: domain)
        //let domain: Domain = Domain(id: 0, name: "")
        //let user: User = User(id: 0, firstName: "", lastName: "", email: "", password: "", birthday: "", gender: "", image: "", nbfollow: 0, nbfollowed: 0, phoneNumber: 0, typeUser: "", domain: domain)
        fetchuser()
        // Do any additional setup after loading the view.
    }
    func fetchuser() {
        
        Database.database().reference().child("users").observeSingleEvent(of: .childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                let domain: Domain = Domain(id: 0, name: "")
                let user: User = User(id: 0, firstName: "", lastName: "", email: "", password: "", birthday: "", gender: "", image: "", nbfollow: 0, nbfollowed: 0, phoneNumber: 0, typeUser: "", domain: domain)
                //userf.setValuesForKeys(dictionary)
                user.firstName = dictionary["name"] as? String
                user.lastName = dictionary ["name"]  as? String
                user.email = dictionary["email"]  as? String
                self.users.append(user)
                
            }
            self.tableview.reloadData()
            for i in 0...self.users.count-1{
                print("Email is "+self.users[i].email!)
            }
            print(snapshot)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NewMessageTableViewCell", owner: self, options: nil)?.first as!NewMessageTableViewCell
        cell.fullname.text = users[indexPath.row].lastName
        cell.message.text = users[indexPath.row].email
        
        //let idvideo = videoArray[indexPath.row]["id"] as! Int
        return cell
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
