//
//  RegisterViewController.swift
//  coachApp
//
//  Created by ESPRIT on 24/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailtxt: DesignableTextField!
    @IBOutlet weak var typeuser: UISwitch!
    @IBOutlet weak var passwordtxt: DesignableTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerToSignUp" {
            if let myVC = segue.destination as? SignUpViewController {
                myVC.email = emailtxt.text!
                myVC.password = passwordtxt.text!
                myVC.typeuser = typeuser.isOn
            }
        }
 
    }
    
    
    @IBAction func suivantAction(_ sender: Any) {
        if(emailtxt.text == "" || passwordtxt.text == "" ){
            //alert
            let alert = UIAlertController(title: "Field empty", message: "Please fil the field empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            //performsegue
            performSegue(withIdentifier: "registerToSignUp", sender: nil)
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
