//
//  LoggedinViewController.swift
//  instagram
//
//  Created by Israel Andrade on 2/21/18.
//  Copyright © 2018 Israel Andrade. All rights reserved.
//

import UIKit
import Parse
class LoggedinViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!

    var posts: [PFObject]?
    
    @IBAction func onCompose(_ sender: Any) {
            NotificationCenter.default.post(name: NSNotification.Name("didCompose"), object: nil)
    }
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LoggedinViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        fetchPost()
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchPost()
    }
    
    func fetchPost() {
        //self.activityIndicator.startAnimating()
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            self.posts = posts
            if let posts = posts {
                // do something with the array of object returned by the call
                for post in posts {
                    // access the object as a dictionary and cast type
                    //print(post.value(forKey: "caption") as! String)
                    //post.value(forKey: "image") as! UIImage
                    
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()

            } else {
                // handle error
                print("No Posts")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(posts != nil){
            return (posts?.count)!

        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(posts != nil) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell", for: indexPath) as! PostCellTableViewCell
            let post = posts![indexPath.row]
            let caption = post.value(forKey: "caption")
            let picture = post.value(forKey: "media") as? PFFile
            if(picture != nil) {
                picture!.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                    if(imageData != nil) {
                        let image = UIImage(data: imageData!)
                        cell.picture.image = image
                    }
            })
            }
            
            cell.caption.text = caption as? String
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell", for: indexPath) as! PostCellTableViewCell

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let post = posts?[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.post = post
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
