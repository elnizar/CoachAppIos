//
//  ProfileFreindViewController.swift
//  coachApp
//
//  Created by ESPRIT on 21/04/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ProfileFreindViewController: UIViewController {
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var follow: UILabel!
    @IBOutlet weak var myfreinds: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var btnfollow: UIButton!
    @IBOutlet weak var descrption: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var imagecover: UIImageView!
    var email = UserDefaults.standard.string(forKey: "emailfreind")!
    let getUserAbonne = "http://172.19.20.20/coachAppService/web/app_dev.php/getallfollow/"
    let followingURL = "http://172.19.20.20/coachAppService/web/app_dev.php/following/"
    let getUserConnectedURL = "http://172.19.20.20/coachAppService/web/app_dev.php/getUserConnected/"
    var mylistfollwing = [AnyObject]()
    var mylistfollow = [AnyObject]()
    var userFreinds = [AnyObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullname.text = email
        self.imageprofile.layer.cornerRadius = self.imageprofile.frame.size.width / 2
        self.imageprofile.clipsToBounds = true
        
   
        // Do any additional setup after loading the view.
        getUserConnected() { (reviews) in
            let firstname = reviews.firstName
            let lastname =  reviews.lastName
            self.fullname.text = firstname! + " " + lastname!
            let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" + reviews.image!)
            
            //emissionImg?.af_setImage(withURL: downloadURL! as URL)
            self.imageprofile.af_setImage(withURL: downloadURL! as URL)
            self.imagecover.af_setImage(withURL: downloadURL! as URL)
        }
        
        getNumberFollow() { (reviews) in
            
            self.follow.text = String(reviews)
            self.myfreinds.text = String(reviews)
        }
        getNumberFollowIng() { (reviews) in
            self.following.text = String(reviews)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func followAction(_ sender: Any) {
        if(btnfollow.titleLabel?.text=="UnFollow"){
            btnfollow.backgroundColor = UIColor.blue
            btnfollow.setTitleColor(UIColor.white, for: .normal)

            btnfollow.setTitle("Follow", for: .normal)

        }
        else{
            btnfollow.backgroundColor = UIColor.white
            btnfollow.setTitleColor(UIColor.blue, for: .normal)
            btnfollow.setTitle("UnFollow", for: .normal)

        }

        DispatchQueue.main.async {
            let parameters = [
                "emailMe": UserDefaults.standard.string(forKey: "email")!,
                "emailYou": self.email,
                ]
            Alamofire.request(self.followingURL, method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    let res = response.result.value as! NSDictionary
                    print(res)
                    //res.object(forKey: "nbFollowedYou")
                    print(res.object(forKey: "nbFollowedYou") as! Int)
                    let nbfollowing = res.object(forKey: "nbFollowedYou") as! Int
                    self.following.text = String(nbfollowing)
                case .failure(let error):
                    print(error)
                }
                
                
            }
        }

       
        


        
    }
    
    func getUserConnected(completion: @escaping (User) -> Void)  {
        print(email)
        print("aaaaa")
        let parameters = [
            "email": email,
            ]
        Alamofire.request(getUserConnectedURL, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                let dict = response.result.value as? Dictionary<String,AnyObject>
                let res = dict!["user"] as! NSDictionary
                print(res)
                //example if there is an id
                let domain: Domain = Domain(id: 0, name: "")

                
                let firstname = res.object(forKey: "first_name")!
                let id = res.object(forKey: "id")!
                let phonenumber = res.object(forKey: "phone_num")!
                let lastName = res.object(forKey: "last_name")!
                let image = res.object(forKey: "image")!
                let email = res.object(forKey: "email")!
                let user: User = User(id: 0, firstName: "", lastName: "", email: "", password: "", birthday: "", gender: "", image: "", nbfollow: 0, nbfollowed: 0, phoneNumber: 0, typeUser: "", domain: domain)
                user.firstName = firstname as? String
                user.id = id as? Int
                user.phoneNumber = phonenumber as? Int
                user.lastName = lastName as? String
                user.image = image as? String
                user.email = email as? String
                completion(user)

            case .failure(let error):
                print(error)
            }
            
            
        }
    }

    
    func loadlist () {
        let parameters = [
            "email": UserDefaults.standard.string(forKey: "email")!,
            ]
        Alamofire.request(getUserAbonne, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    if let inerDict = dict["mylistfollow"] {
                        print(inerDict)
                        self.mylistfollwing = inerDict as! [AnyObject]
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
    }

    

    func getNumberFollowIng(completion: @escaping (Int) -> Void)  {
        let parameters = [
            "email": email
            ]
        Alamofire.request(getUserAbonne, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    if let inerDict = dict["mylistfollwing"] {
                        print(inerDict)
                        self.mylistfollwing = inerDict as! [AnyObject]
                        completion(self.mylistfollwing.count)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getNumberFollow(completion: @escaping (Int) -> Void)  {
        let parameters = [
            "email": email,
            ]
        Alamofire.request(getUserAbonne, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    if let inerDict = dict["mylistfollow"] {
                        print(inerDict)
                        self.mylistfollow = inerDict as! [AnyObject]
                        completion(self.mylistfollow.count)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func backAct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emchibrasomk(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func messageAct(_ sender: Any) {
        performSegue(withIdentifier: "profileToMessage", sender: nil)
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
