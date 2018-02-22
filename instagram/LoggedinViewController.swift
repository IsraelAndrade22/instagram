//
//  LoggedinViewController.swift
//  instagram
//
//  Created by Israel Andrade on 2/21/18.
//  Copyright © 2018 Israel Andrade. All rights reserved.
//

import UIKit
import Parse
class LoggedinViewController: UIViewController {

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if(PFUser.current() == nil) {
                print("You're logged out")
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)

            } else {
                print("Not logged out")
            }
        }
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
