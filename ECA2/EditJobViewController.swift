//
//  EditJobViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 15/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class EditJobViewController: UIViewController {
    
    var resumeViewController : ResumeViewController?
    var resume: Resume?
    var indexPath : Int?
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editCompany: UITextField!
    @IBOutlet weak var editCity: UITextField!
    
    @IBOutlet weak var editFrom: UITextField!
    
    @IBOutlet weak var editTo: UITextField!
    
    @IBAction func save(_ sender: Any) {
        resumeViewController!.updateUserData(resume!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        
//        editTitle.text = resumeViewController?jobexp[indexPath].title
        resume = resumeViewController?.resume
        
        
    }

}
