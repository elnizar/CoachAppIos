//
//  SearchViewController.swift
//  coachApp
//
//  Created by ESPRIT on 23/04/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
class SearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableview: UITableView!
    let getAllUserURL = "http://172.19.20.20/coachAppService/web/app_dev.php/getAllUser/"+UserDefaults.standard.string(forKey: "email")!
    var listUser = [User]()
    var userArray = [AnyObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self, options: nil)?.first as!SearchTableViewCell
        let img = listUser[indexPath.row].image
        let firstName = listUser[indexPath.row].firstName
        let lastName = listUser[indexPath.row].lastName
        let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" + img!)

        //emissionImg?.af_setImage(withURL: downloadURL! as URL)
        let name = firstName! + " " + lastName!
        cell.imageuser.af_setImage(withURL: downloadURL! as URL)
        cell.fullname.text = name

        
        return cell
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.3
        let transform = CATransform3DTranslate(CATransform3DIdentity, 100, 0, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 0.75){
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(getAllUserURL, method: .get).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let innerDict = dict["listuser"] {
                    print(innerDict)
                    self.userArray = innerDict as! [AnyObject]
                    
                        for i in 0...innerDict.count-1 {
                            var domain: Domain = Domain(id: 0, name: "")
                            var user: User = User(id: 0, firstName: "", lastName: "", email: "", password: "", birthday: "", gender: "", image: "", nbfollow: 0, nbfollowed: 0, phoneNumber: 0, typeUser: "", domain: domain)
                        let firstname = self.userArray[i]["first_name"] as! String
                        let lastname = self.userArray[i]["last_name"] as! String
                        let email = self.userArray[i]["email"] as! String
                        let image = self.userArray[i]["image"] as! String
                        //let id = self.userArray[i]["id"] as! Int
                            user.firstName = firstname
                            user.lastName = lastname
                            user.email = email
                            user.image = image
                        self.listUser.append(user)
                        }
                    
                    self.tableview.reloadData()
                }
               
        // Do any additional setup after loading the view.
            }
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
