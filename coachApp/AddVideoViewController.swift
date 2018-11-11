//
//  AddVideoViewController.swift
//  coachApp
//
//  Created by ESPRIT on 25/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
import Alamofire
class AddVideoViewController: UIViewController {
    @IBOutlet var videoview: YouTubePlayerView!
    var geturl = "http://172.19.20.20/coachAppService/web/app_dev.php/converturl/"
    var addVideo = "http://172.19.20.20/coachAppService/web/app_dev.php/addVideo/"
    
    @IBOutlet var url: DesignableTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }

    @IBAction func cotmyAction(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:"http://www.youtube.com")! as URL)

    }
    @IBAction func seturlAction(_ sender: Any) {
        if url.text != ""
        {

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func watchAction(_ sender: Any) {
        getYoutubeId() { response in
            // Do your stuff here
            print("Returned String Data is: \(response)")
            let urlid = response
            let myVideoURL = NSURL(string: urlid)
            self.videoview.loadVideoURL(myVideoURL as! URL)
            //videoview.play()
        }

        //nizar.elhraiech@esprit.tn
        //https://www.youtube.com/watch?v=2dH7lJyKtjo
    }
    
    func getYoutubeId(completion: @escaping (String) -> Void)  {
        let parameters = [
            "url": url.text! ,
            ]
        var youtubeUrl = ""
        Alamofire.request(geturl, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                
                let res = response.result.value as! NSDictionary
                //example if there is an id
                    youtubeUrl = res.object(forKey: "url") as! String
                    completion(youtubeUrl)

                print(youtubeUrl)
            case .failure(let error):
                print(error)
            }
            
        }
        print(youtubeUrl)
    }
    
    @IBAction func addvideoAction(_ sender: Any) {
        if url.text != "" {
            let parameters = [
                "url": url.text! ,
                "specialty" : "sport",
                "domain" : "foot",
                "email" : UserDefaults.standard.string(forKey: "email")!,
                "name" : "nom video",
                ]
            Alamofire.request(addVideo, method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    
                    let res = response.result.value as! NSDictionary
                    print(UserDefaults.standard.string(forKey: "email")!)
                    print(res)
                    if res.object(forKey: "error") as! Bool {
                        let alert = UIAlertController(title: "Add video Failed", message: "Please Fill The Fileds", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,  handler: {(action:UIAlertAction!) in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    //example if there is an id
                case .failure(let error):
                    print(error)
                }
                
            }
        }
        else {
            let alert = UIAlertController(title: "Add video Failed", message: "Please Fill The Fileds", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
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
