//
//  DetailViewController.swift
//  instagram
//
//  Created by Israel Andrade on 2/26/18.
//  Copyright © 2018 Israel Andrade. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    var post: PFObject!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            /*
             post.likesCount = 0
             post.commentsCount = 0
             */
            let cap = post.value(forKey: "caption") as? String
            caption.text = "Caption: " + cap!
            //caption.text += post.value(forKey: "caption") as? String
            let likes = post.value(forKey: "likeCount") as? String
            if(likes != nil) {
                numberOfLikes.text = "Likes: " + likes!

            } else {
                numberOfLikes.text = "Likes: 0"
            }
            let commentCount = post.value(forKey: "commentsCount") as? String
            if(commentCount != nil) {
                numberOfComments.text = "Number of Comments: " + commentCount!
            } else {
                numberOfComments.text = "Number of Comments: 0"
            }
            print(post.value(forKey: "commentsCount") as? String)
            let picture = post.value(forKey: "media") as? PFFile
            if(picture != nil) {
                picture!.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                    if(imageData != nil) {
                        let image = UIImage(data: imageData!)
                        self.postImage.image = image
                    }
                })
            }
        }
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
