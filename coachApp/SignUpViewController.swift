//
//  SignUpViewController.swift
//  coachApp
//
//  Created by ESPRIT on 23/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
class SignUpViewController: UIViewController {
    
    var email = ""
    var password = ""
    var typeuser = false
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var firstnametxt: DesignableTextField!
    
    @IBOutlet weak var numbertxt: DesignableTextField!
    @IBOutlet weak var lastnametxt: DesignableTextField!
    let inscription = "http://172.19.20.20/coachAppService/web/app_dev.php/inscription/"
    @IBOutlet weak var sex: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        numbertxt.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view.
        date.addTarget(self, action: #selector(myTargetFunction), for: UIControlEvents.touchDown)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func myTargetFunction(textField: UITextField) {
        let message = "\n\n\n\n\n\n"
        let alert = UIAlertController(title: "Please Select City", message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.isModalInPopover = true
        let datePicker = UIDatePicker()
        
        // Posiiton date picket within a view
        datePicker.frame = CGRect(x: 10, y: 50, width: 325, height: 120)
        
        // Set some of UIDatePicker properties
        datePicker.datePickerMode = .date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2008/01/01")
        datePicker.maximumDate = someDateTime
        
        datePicker.backgroundColor = UIColor.white
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        
        //Add the picker to the alert controller
        alert.view.addSubview(datePicker)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //Perform Action
        })
        
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        self.parent!.present(alert, animated: true, completion: nil)
    }

    
    

    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format

        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        date.text = selectedDate
        print("Selected value \(selectedDate)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signupToLogin" {
            if segue.destination is LoginViewController {
            }
        }
    }
    
    func inscriptionf(completion: @escaping (Bool) -> Void)  {
        var dom = ""
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print (error!)
                return
            }
            guard let uid = user?.uid else{
                return
            }
            
            let name = self.firstnametxt.text! + " " + self.lastnametxt.text!
            let ref = Database.database().reference(fromURL: "https://coachapp-dde13.firebaseio.com/")
            let usersRefernce = ref.child("users").child(uid)
            let values = ["name":name,"email":self.email]
            usersRefernce.updateChildValues(values, withCompletionBlock: {(user, error) in
                if error != nil{
                    print (error)
                    return
                }
            }
                
            )
        }
        
        if typeuser == false {
            dom = "user"
        }
        else {
            dom = "expert"
        }
        let parameters = [
            "email": email ,
            "password" : password ,
            "firstName" : firstnametxt.text!,
            "lastName" : lastnametxt.text! ,
            "birthday" : date.text! ,
            "gender" : sex.titleForSegment(at: sex.selectedSegmentIndex)! ,
            "phone_num" : numbertxt.text! ,
            "domain" : "Sport" ,
            "attestation" : "attestation" ,
            "image" : "image" ,
            "name" : "name" ,
            ] as [String : Any]
        var youtubeUrl = ""
        Alamofire.request(inscription, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                
                let res = response.result.value as! NSDictionary
                //example if there is an id
                let error = res.object(forKey: "error") as! Bool
                print(error)
                completion(error)
                
            case .failure(let error):
                print(error)
            }
            
        }
        print(youtubeUrl)
    }

    @IBAction func registerAction(_ sender: Any) {
        if(firstnametxt.text == "" || lastnametxt.text == "" || numbertxt.text == "" || date.text == ""){
            //alert
            let alert = UIAlertController(title: "Field empty", message: "Please fil the field empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            inscriptionf() { (reviews) in
                var reviewJson = reviews
                DispatchQueue.main.async {
                    print(reviewJson)
                if reviewJson == true {
                        let alert = UIAlertController(title: "Register Failed", message: "Your Register is Faled Please Try Again", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,  handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Registered", message: "Your Register is success Try To Login", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                            self.performSegue(withIdentifier: "signupToLogin", sender: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }

            }
            
        }

        }
            
    

            
    
        }

