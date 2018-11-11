//
//  HomeViewController.swift
//  coachApp
//
//  Created by ESPRIT on 24/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Firebase
class HomeViewController: UIViewController , UITableViewDelegate  , UITableViewDataSource{
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var btnp: UIBarButtonItem!

    let getAllVideURL = "http://172.19.20.20/coachAppService/web/app_dev.php/getAllvideo/"+UserDefaults.standard.string(forKey: "email")!
    let likevideoURL = "http://172.19.20.20/coachAppService/web/app_dev.php/likevideo/"
    var listvideo = [Video]()
    var videoArray = [AnyObject]()
    var videoLikedArray = [AnyObject]()
    var test = 0
    var tabidjaime = [Int]()
    
    struct jaime {
        var idvideo: Int
        var nbjaime: Int
        
    }
    var tabnbjaime = [jaime]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let role = UserDefaults.standard.string(forKey: "role")!
        if(role == "user"){
            self.btnp.isEnabled = false
        }
        else{
            self.btnp.isEnabled = true
        }
        Alamofire.request(getAllVideURL, method: .get).responseJSON { response in
          let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    if let innerDict = dict["videos"] {
                        print(innerDict)
                        self.videoArray = innerDict as! [AnyObject]
                        for i in 0...innerDict.count-1 {
                            let nbjaime = self.videoArray[i]["nbjaime"] as! Int
                            let idvideo = self.videoArray[i]["id"] as! Int
                            self.tabnbjaime.append(jaime(idvideo: idvideo, nbjaime: nbjaime))
                        }

                        self.tableview.reloadData()
                    }
                    if let inerDict = dict["videoLiked"] {
                        print(inerDict)
                        self.videoLikedArray = inerDict as! [AnyObject]
                        if(inerDict.count>0){
                            for i in 0...inerDict.count-1 {
                                let videol = self.videoLikedArray[i]["video"] as! NSDictionary
                                let idvideol = videol.object(forKey: "id") as? Int
                                self.tabidjaime.append(idvideol!)
                                
                            }
                            self.tableview.reloadData()
                        }

                        
                    }
                }
                /*var nbDeLignes: Int = 0
                 
                 while nbDeLignes <= 3 {
                 print(jArray![nbDeLignes]["id"]!)
                 nbDeLignes += 1
                 }*/
            //example if there is an id
     
            
        }
        
        print(videoArray)
        
        
        //print(res)
        // Do any additional setup after loading the view.
    }
    
    
    func loadlist () {
        Alamofire.request(getAllVideURL, method: .get).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let inerDict = dict["videoLiked"] {
                    print(inerDict)
                    self.videoLikedArray = inerDict as! [AnyObject]
                }
            }
            /*var nbDeLignes: Int = 0
             
             while nbDeLignes <= 3 {
             print(jArray![nbDeLignes]["id"]!)
             nbDeLignes += 1
             }*/
            //example if there is an id
            
            
        }
    }

    func getAllVideo(completion: @escaping ([Video]) -> Void) {
        
/*
         var videTab = [Video]()
         
         let jArray = videoArray as? [NSDictionary]
         let taytab = jArray!.count
         print(taytab)
         var i = 0
         for nbtab in 0...taytab-1{
         let domain: Domain = Domain(id: 0, name: "")
         let speciality: Speciality = Speciality(id: 0, name: "", domain: domain)
         let user: User = User(id: 0, firstName: "", lastName: "", email: "", password: "", birthday: "", gender: "", image: "", nbfollow: 0, nbfollowed: 0, phoneNumber: 0, typeUser: "", domain: domain)
         i = i + 1
         let video: Video = Video(id: 0, user: user, name: "", url: "", description: "", nbJaime: 0, nbComment: 0, domain: domain, speciality: speciality)
         //print(jArray![nbtab]["name"]!)
         video.name = jArray![nbtab]["name"]! as? String
         let domainjson = jArray![nbtab]["domain"] as! NSDictionary
         let specialtyjson = jArray![nbtab]["specialty"] as! NSDictionary
         video.speciality?.id = specialtyjson.object(forKey: "id") as? Int
         video.speciality?.name = specialtyjson.object(forKey: "name") as? String
         let userjson = jArray![nbtab]["user"] as! NSDictionary
         video.user?.id = userjson.object(forKey: "id") as? Int
         video.user?.email = userjson.object(forKey: "email") as? String
         video.user?.nbfollow = domainjson.object(forKey: "nbfollow") as? Int
         video.user?.nbfollowed = domainjson.object(forKey: "nbfollowed") as? Int
         video.nbJaime = jArray![nbtab]["nbjaime"]! as? Int
         video.nbComment = jArray![nbtab]["nbcomment"]! as? Int
         video.domain?.id = domainjson.object(forKey: "id") as? Int
         video.domain?.name = domainjson.object(forKey: "name") as? String
         //print(video.domain!.name!)
         videTab.append(video)
         
         }
         self.listvideo = videTab
 */
    }
    
    @IBAction func logAction(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "email")
        performSegue(withIdentifier: "homeToFirst", sender: nil)
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(videoArray.count)
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
    
    @objc func doubleTapped(_ recognizer: UITapGestureRecognizer) {
        print(recognizer.view!.tag)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print(tapGestureRecognizer.view!.tag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "toDetails"{
            if let destinationVC = segue.destination as? DetailsViewController {
            }
        }*/
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self, options: nil)?.first as!PostTableViewCell

        
            let idvideo = videoArray[indexPath.row]["id"] as! Int
        
         let idvideotest = videoArray[indexPath.row]["id"] as! Int
            //let nbjaime = videoArray[indexPath.row]["nbjaime"] as! Int
        for i in 0...tabnbjaime.count-1{
            if tabnbjaime[i].idvideo == idvideo {
                cell.nblike.setTitle(String(tabnbjaime[i].nbjaime), for: UIControlState.normal)

            }
        }
            cell.likebutton.accessibilityHint = String(idvideotest)
            cell.likebutton.addTarget(self, action: #selector(self.connected(sender:)), for: .touchUpInside)
        cell.commentbutton.accessibilityHint = String(idvideotest)
        cell.commentbutton.addTarget(self, action: #selector(self.commentfunc(sender:)), for: .touchUpInside)
        
            cell.likebutton.tag = indexPath.row
            
            if tabidjaime.count != 0{
                for i in 0...tabidjaime.count-1 {
                    
                    if(tabidjaime[i] == idvideo ){
                        cell.likebutton.setImage(UIImage(named: "like-2"), for: UIControlState.normal)
                        
                    }
                }
            }
            
            //let file:String = tvShow["image"] as! String
            let user = videoArray[indexPath.row]["user"] as! NSDictionary
            let img = user.object(forKey: "image") as? String
            let firstName = user.object(forKey: "first_name") as? String
            let lastName = user.object(forKey: "last_name") as? String
            let url = videoArray[indexPath.row]["url"] as! String
            print(img!)
            let downloadURL = NSURL(string: "http://172.19.20.20/coachAppService/web/uploads/images/" + img!)
            
            //emissionImg?.af_setImage(withURL: downloadURL! as URL)
            let name = firstName! + " " + lastName!
            cell.imageuser.af_setImage(withURL: downloadURL! as URL)
            cell.nameuser.text = name
            let myVideoURL = NSURL(string: url)
            
            cell.videYoutube.loadVideoURL(myVideoURL! as URL)

        /*let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(_:)))
        tap.numberOfTapsRequired = 1
        cell.label.tag = indexPath.row
        cell.label.isUserInteractionEnabled = true
        cell.label.addGestureRecognizer(tap)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))
        cell.img.isUserInteractionEnabled = true
        cell.img.tag = indexPath.row
        cell.img.addGestureRecognizer(tapGestureRecognizer)*/
    
        
        
        return cell
    }
    @objc func connected(sender: UIButton){
        test = 1 ;
        let buttonTag = sender.tag
        let idvideostr = sender.accessibilityHint
        if(tabidjaime.count>0){
            for i in 0...tabidjaime.count-1 {
                
                print(tabidjaime[i])
                
                
            }
            print("neww")
            for i in 0...tabnbjaime.count-1 {
                
                print(tabnbjaime[i].idvideo)
                print(tabnbjaime[i].nbjaime)
                
                
                
            }
        }



        var g : NSIndexPath = NSIndexPath(row: buttonTag, section: 0)
        var t : PostTableViewCell = self.tableview.cellForRow(at: g as IndexPath) as!  PostTableViewCell
        //loadlist()
        if t.likebutton.currentImage == UIImage(named: "like"){
            t.likebutton.setImage(UIImage(named: "like-2"), for: UIControlState.normal)
            let v = t.nblike.currentTitle
            var nbl = Int(v!)
            nbl = nbl! + 1
            t.nblike.setTitle(String(nbl!), for: UIControlState.normal)
            tabnbjaime.append(jaime(idvideo: Int(idvideostr!)!, nbjaime: nbl!))
            tabidjaime.append(Int(idvideostr!)!)

            
        }else {
            t.likebutton.setImage(UIImage(named: "like"), for: UIControlState.normal)
            let v = t.nblike.currentTitle
            var nbl = Int(v!)
            nbl = nbl! - 1
            t.nblike.setTitle(String(nbl!), for: UIControlState.normal)
            for i in 0...tabnbjaime.count-1{
                if tabnbjaime[i].idvideo == Int(idvideostr!)!{
                    tabnbjaime[i].nbjaime = nbl!
                }
            }
            for i in 0...tabidjaime.count-1{
                if tabidjaime[i] == Int(idvideostr!)!{
                    tabidjaime.remove(at: i)
                    break
                }
            }

            
        }
        
        
        //self.tableview.reloadData();
        let idvideo = videoArray[buttonTag]["id"] as! Int
        let parameters = [
            "email": UserDefaults.standard.string(forKey: "email")!,
            "id": String(idvideo) ,
            ]
        Alamofire.request(likevideoURL, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:

                let res = response.result.value as! NSDictionary
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
    
    @objc func commentfunc(sender: UIButton){
        test = 1 ;
        let buttonTag = sender.tag
        let idvideostr = sender.accessibilityHint
        UserDefaults.standard.set(idvideostr, forKey: "idvideo") //setObject
        performSegue(withIdentifier: "homeToComment", sender: nil)
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutAct(_ sender: Any) {
        do {
            UserDefaults.standard.removeObject(forKey: "email")
            performSegue(withIdentifier: "homeToFirst", sender: nil)
            try Auth.auth().signOut()
        }catch let logoutEroor{
            print(logoutEroor)
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
