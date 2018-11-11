//
//  CommentViewController.swift
//  coachApp
//
//  Created by ESPRIT on 27/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class CommentViewController: UIViewController , UITableViewDelegate  , UITableViewDataSource{

    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var conntents: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var error = false
    let getAllComment = "http://172.19.20.20/coachAppService/web/app_dev.php/getcommentvideo/"
    let commentvideoURL = "http://172.19.20.20/coachAppService/web/app_dev.php/commentvideo/"
    var commentVideoArray = [AnyObject]()
    
    @IBOutlet weak var firstcom: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" + UserDefaults.standard.string(forKey: "image")!)
        
        //emissionImg?.af_setImage(withURL: downloadURL! as URL)
        imageUser.af_setImage(withURL: downloadURL! as URL)
        print( UserDefaults.standard.string(forKey: "idvideo")!)
        let parameters = [
            "id":  UserDefaults.standard.string(forKey: "idvideo")!
   
            ]
        Alamofire.request(getAllComment, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    let result = response.result

                    let dict = result.value as? Dictionary<String,AnyObject>
                    let innerDict = dict!["comments"]
                    let inneerDict = dict!["error"]
                    print(innerDict!)
                    self.error = inneerDict! as! Bool
                    self.commentVideoArray = innerDict! as! [AnyObject]
                    self.tableview.reloadData()

                }
                
        
                
                // let res = response.result.value as! NSDictionary
                //et nblike = res.object(forKey: "nblike") as! Int
                // cell.nblike.setTitle(String(nblike), for: UIControlState.normal)
                //self.tableview.reloadData();
                
                //example if there is an id
                //let error = res.object(forKey: "error") as! Bool
                //print(error)
                
            case .failure(let error):
                print(error)
            }
            
        }
        
        
            /*var nbDeLignes: Int = 0
             
             while nbDeLignes <= 3 {
             print(jArray![nbDeLignes]["id"]!)
             nbDeLignes += 1
             }*/
            //example if there is an id
            
            
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendCommentAction(_ sender: Any) {
        sendcomment()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("hereeeeeeeeee")
        print(error)
        if(error == true){
            print("here")
            firstcom.text = "Be the first to write a comment "

        }
        

        return commentVideoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CommentTableViewCell", owner: self, options: nil)?.first as!CommentTableViewCell

     
            let contents = commentVideoArray[indexPath.row]["contents"] as! String
            
            let user = commentVideoArray[indexPath.row]["user"] as! NSDictionary
            let img = user.object(forKey: "image") as? String
            let firstName = user.object(forKey: "first_name") as? String
            let lastName = user.object(forKey: "last_name") as? String
            print(img!)
            let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" + img!)
            
            //emissionImg?.af_setImage(withURL: downloadURL! as URL)
            let name = firstName! + " " + lastName!
            cell.img.af_setImage(withURL: downloadURL! as URL)
            cell.fullname.text = name
            cell.contents.text = contents

        
       
        return cell
        
    }
    func sendcomment (){
        let parameters = [
            "id":  UserDefaults.standard.string(forKey: "idvideo")!,
            "contents": conntents.text!,
            "email":  UserDefaults.standard.string(forKey: "email")!

            ] as [String : Any]
        Alamofire.request(commentvideoURL, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
               
                self.conntents.text = ""
                    let result = response.result
                    
                    let dict = result.value as? Dictionary<String,AnyObject>
                    let innerDict = dict!["comments"]
                   
                    print(innerDict!)
                  
                    self.commentVideoArray = innerDict! as! [AnyObject]
                    self.tableview.reloadData()
                    
                
                
                
                
                // let res = response.result.value as! NSDictionary
                //et nblike = res.object(forKey: "nblike") as! Int
                // cell.nblike.setTitle(String(nblike), for: UIControlState.normal)
                //self.tableview.reloadData();
                
                //example if there is an id
                //let error = res.object(forKey: "error") as! Bool
                //print(error)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
