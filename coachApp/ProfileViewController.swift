//
//  ProfileViewController.swift
//  coachApp
//
//  Created by ESPRIT on 16/04/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ProfileViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    
    
    @IBOutlet weak var imgcover: UIImageView!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var myfreinds: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var follow: UILabel!
    @IBOutlet weak var myview: UIView!
    var emailfreind = ""

    @IBOutlet weak var collectionview: UICollectionView!
    var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    let getUserAbonne = "http://172.19.20.20/coachAppService/web/app_dev.php/getallfollow/"
    var mylistfollow = [AnyObject]()
    
    var mylistfollwing = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //self.imgprofile.layer.cornerRadius = 10.0
        self.imgprofile.layer.cornerRadius = self.imgprofile.frame.size.width / 2
        self.imgprofile.clipsToBounds = true
        
        myview.layer.borderWidth = 1
        let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" + UserDefaults.standard.string(forKey: "image")!)
        
        //emissionImg?.af_setImage(withURL: downloadURL! as URL)
        imgprofile.af_setImage(withURL: downloadURL! as URL)
        imgcover.af_setImage(withURL: downloadURL! as URL)
        let firstName = UserDefaults.standard.string(forKey: "firstName")
        let lastName = UserDefaults.standard.string(forKey: "lastName")
        
        let name = firstName! + " " + lastName!
        fullname.text = name
        myview.layer.borderColor = UIColor.darkGray.cgColor
        loadlist();
        getNumberFollow() { (reviews) in
           
            self.follow.text = String(reviews)
            self.myfreinds.text = String(reviews)
        }
        getNumberFollowIng() { (reviews) in
            self.following.text = String(reviews)
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    func getNumberFollowIng(completion: @escaping (Int) -> Void)  {
        let parameters = [
            "email": UserDefaults.standard.string(forKey: "email")!,
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
            "email": UserDefaults.standard.string(forKey: "email")!,
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
                        self.mylistfollow = inerDict as! [AnyObject]
                        self.collectionview.reloadData()
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mylistfollow.count
    }
    
    
    private func collectionView(_ collectionView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mylistfollow[indexPath.row])
        //performSegue(withIdentifier: "toDetails", sender: nil)
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! MyCollectionViewCell

        
        //emissionImg?.af_setImage(withURL: downloadURL! as URL)
         let firstname = mylistfollow[indexPath.row]["first_name"] as! String
         let lastname = mylistfollow[indexPath.row]["last_name"] as! String
         let image = mylistfollow[indexPath.row]["image"] as! String
        let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" +
        image)
        cell.imageuser.af_setImage(withURL: downloadURL! as URL)
        cell.imageuser.layer.cornerRadius = cell.imageuser.frame.size.width / 2
        cell.imageuser.clipsToBounds = true

        cell.fullname.text = firstname + " " + lastname


        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))
        cell.imageuser.isUserInteractionEnabled = true
        cell.imageuser.accessibilityHint = mylistfollow[indexPath.row]["email"] as! String
        cell.imageuser.tag = indexPath.row
        cell.imageuser.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        loadlist();
        getNumberFollow() { (reviews) in
            
            self.follow.text = String(reviews)
            self.myfreinds.text = String(reviews)
        }
        getNumberFollowIng() { (reviews) in
            self.following.text = String(reviews)
            
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        emailfreind = tapGestureRecognizer.view!.accessibilityHint!
        UserDefaults.standard.set(emailfreind, forKey: "emailfreind")
        performSegue(withIdentifier: "toDetails", sender: nil)
        print(tapGestureRecognizer.view!.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            if let destinationVC = segue.destination as? ProfileFreindViewController {
                destinationVC.email = emailfreind
            }
        }
    }

    @IBAction func updatephotoAct(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
@objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgprofile.image = pickedImage
        imgprofile.contentMode = .scaleAspectFill
        imgcover.image = pickedImage
        imgcover.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        uploadimage()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func uploadimage () {
        
        let myUrl = "http://172.19.20.20/coachAppService/web/app_dev.php/setimage/"
        
        
        let imageData = UIImageJPEGRepresentation(imgprofile.image!, 1)
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        let param = [
            "email" : UserDefaults.standard.string(forKey: "email")!,
            "image":base64String!
            ] as [String : Any]
        
        Alamofire.request(myUrl,method: .post, parameters: param).responseJSON
            {
                response in
                let res = response.result.value as! NSDictionary

                print(response)
                let imagename = res.object(forKey: "image") as! String
                 UserDefaults.standard.set(imagename, forKey: "image")

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
