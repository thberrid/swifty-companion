//
//  DataSources.swift
//  swifty-companion
//
//  Created by thberrid on 27/06/2021.
//  Copyright © 2021 thberrid. All rights reserved.
//

import Foundation
import UIKit

class ProjectsDataSource : NSObject, UITableViewDataSource {

    var projectsArray:[ProjectsUsers]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("# row in section: \(projectsArray?.count ?? 0)")
        return projectsArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! GenericCustomCells
        let name = projectsArray?[indexPath.row].project?.name
        cell.ElementName.text = name
        if let note = projectsArray?[indexPath.row].final_mark {
            cell.ElementNote.text = String(describing: note)
        } else { cell.ElementNote.text = "Not yet" }
        return cell
    }
}

class SkillsDataSource : NSObject, UITableViewDataSource {

    var skillsArray:[Skills]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("# row in section: \(skillsArray?.count ?? 0)")
        return skillsArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell") as! GenericCustomCells
        let name = skillsArray?[indexPath.row].name
        cell.ElementName.text = name
        let note = skillsArray?[indexPath.row].level
        cell.ElementNote.text = String(describing: note!)
        return cell
    }
}
