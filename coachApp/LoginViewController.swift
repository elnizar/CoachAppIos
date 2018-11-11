//
//  LoginViewController.swift
//  coachApp
//
//  Created by ESPRIT on 24/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
class LoginViewController: UIViewController {
    let connectUser = "http://172.19.20.20/coachAppService/web/app_dev.php/users/"
    @IBOutlet weak var emailtext: DesignableTextField!
    @IBOutlet weak var passwordtext: DesignableTextField!
    var conncted = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailtext.text! , password: passwordtext.text!) { (user, error) in
            if error != nil {
                print (error!)
                return
            }
            
        }
        let parameters = [
            "email": emailtext.text! ,
            "password": passwordtext.text!,
            ]


        Alamofire.request(connectUser, method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                    case .success:
                        
                        let res = response.result.value as! NSDictionary
                        //example if there is an id

                        
                        let error = res.object(forKey: "error") as! Bool


                        if  error == false {
                            let firstname = res.object(forKey: "firstName")!
                            let lastName = res.object(forKey: "lastName")!
                            let image = res.object(forKey: "image")!
                            let email = res.object(forKey: "email")!
                            let role = res.object(forKey: "role")!
                            UserDefaults.standard.set(role, forKey: "role")
                            UserDefaults.standard.set(firstname, forKey: "firstName") //setObject
                            UserDefaults.standard.set(lastName, forKey: "lastName") //setObject
                            UserDefaults.standard.set(image, forKey: "image") //setObject

                            UserDefaults.standard.set(email, forKey: "email") //setObject
                            self.performSegue(withIdentifier: "loginToHome", sender: nil)
                    }
                        else{
                            

                            let alert = UIAlertController(title: "Login Failed", message: "Your password or mail is wrong", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                    case .failure(let error):
                        print(error)
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
