//
//  ViewController.swift
//  swifty-companion
//
//  Created by thberrid on 6/12/21.
//  Copyright © 2021 thberrid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var InputLogin: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if segue.destination is UserTableViewController {
			let destVC = segue.destination as? UserTableViewController
			destVC?.inputLogin = InputLogin.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).filter { !" \n\t\r".contains($0) }
			destVC?.title = InputLogin.text!
		}
	}

}

