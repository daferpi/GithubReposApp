//
//  ListRepoViewCell.swift
//  GithubReposApp
//
//  Created by abelFernandez on 21/08/2018.
//  Copyright © 2018 abelFernandez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ListRepoViewCell: UITableViewCell {

    @IBOutlet weak var imageRepo: UIImageView!
    @IBOutlet weak var labelNameRepo: UILabel!
    @IBOutlet weak var labelDescriptionRepo: UILabel!
    
    var repoData:Repository? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        let url = URL(string: (repoData?.owner?.avatar_url)!)!
        imageRepo?.af_setImage(withURL: url)
        labelNameRepo?.text = repoData?.full_name
        labelDescriptionRepo?.text = repoData?.description
    }
    
}
