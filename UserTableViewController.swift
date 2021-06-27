//
//  UserTableViewController.swift
//  swifty-companion
//
//  Created by thberrid on 6/14/21.
//  Copyright © 2021 thberrid. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var inputLogin: String?
    var userData: UserData?
    
    let projectsDataSource = ProjectsDataSource()
    let skillsDataSource = SkillsDataSource()
    
    @IBOutlet weak var LabelLogin: UILabel!
    @IBOutlet weak var LabelEval: UILabel!
    @IBOutlet weak var LabelPromo: UILabel!
    @IBOutlet weak var ImageUser: UIImageView!
    @IBOutlet weak var ImageLoader: UIActivityIndicatorView!
    @IBOutlet weak var LevelLabel: UILabel!
    
    @IBOutlet var projectsTableView: UITableView!
    @IBOutlet var skillsTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        userData = UserData()
        
        self.projectsTableView.dataSource = projectsDataSource
        self.skillsTableView.dataSource = skillsDataSource
        
        ImageLoader.startAnimating()
        print("UserTableVC.viewDidLoad with login = \(inputLogin!)")
        if inputLogin != nil {
            userData?.get(login: inputLogin!, completion: fetchData)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userData = nil
    }
    
    // MARK: USER
    
    func fetchData(){
        print("fetching data")
        if let jsonData = userData?.jsonData {
            print("reload data")
            
            projectsDataSource.projectsArray = jsonData.projects_users?.filter {
                $0.project?.name?.count ?? 0 > 0
            }
            self.projectsTableView.reloadData()
            
            skillsDataSource.skillsArray = jsonData.cursus_users?.last?.skills
            self.skillsTableView.reloadData()
            
            if jsonData.login != nil {
                LabelLogin.text = jsonData.login!
            } else {
                LabelLogin.text = "unknown"
                ImageLoader.stopAnimating()
            }
            
            if let level = jsonData.cursus_users?.last?.level {
                LevelLabel.text = String(level)
            } else {
                LevelLabel.text = "\\"
            }
            
            if jsonData.correction_point != nil, let evalPoints:Int = jsonData.correction_point {
                LabelEval.text = String(evalPoints)
            } else {
                LabelEval.text = "\\"
            }
            if let promo = jsonData.pool_year {
                LabelPromo.text = promo
            } else { LabelPromo.text = "no promo" }
            
            if let tmpUrl = jsonData.image_url, let url = URL(string: tmpUrl) {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let urlContents = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let imageData = urlContents, let currentUrl = self?.userData?.jsonData?.image_url, url == URL(string: currentUrl) {
                            self?.ImageUser.image = UIImage(data: imageData)
                            self?.ImageLoader.stopAnimating()
                        }
                    }
                }
            }
        } else {
            LabelLogin.text = "unknown"
            LevelLabel.text = "\\"
            LabelEval.text = "\\"
            LabelPromo.text = "no promo"
            ImageLoader.stopAnimating()
        }
    }
}
