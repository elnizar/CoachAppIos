//
//  NotificationViewController.swift
//  coachApp
//
//  Created by ESPRIT on 11/05/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NotificationTableViewCell", owner: self, options: nil)?.first as!NotificationTableViewCell
        cell.imguser.layer.cornerRadius = cell.imguser.frame.size.width / 2
        cell.imguser.clipsToBounds = true
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
