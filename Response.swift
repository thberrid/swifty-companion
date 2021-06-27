//
//  Response.swift
//  swifty-companion
//
//  Created by thberrid on 21/06/2021.
//  Copyright © 2021 thberrid. All rights reserved.
//

import Foundation

struct Skills: Decodable {
    let level: Float?
    let name: String?
}

struct Cursus: Decodable {
    let level: Float?
    let skills: [Skills]?
}

struct Project: Decodable {
    let name: String?
}

struct ProjectsUsers: Decodable {
    let status: String?
    let final_mark: Float?
    let project: Project?
}

struct Response: Decodable {
    
    let login: String?
    let pool_year: String?
    let correction_point: Int?
    let image_url: String?
    let cursus_users: [Cursus]?
    let projects_users: [ProjectsUsers]?
}
