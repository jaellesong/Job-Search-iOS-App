//
//  EditNameViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 15/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class EditNameViewController: UIViewController {
    var resumeViewController : ResumeViewController?
    var resume: Resume?
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editHead: UITextField!
    @IBOutlet weak var editCity: UITextField!
    
    @IBOutlet weak var editEmail: UITextField!
    
    @IBOutlet weak var editAbout: UITextField!
    
    @IBAction func save(_ sender: Any) {
        resume!.name = editName.text!
        resume!.headline = editHead.text!
        resume!.city = editCity.text!
        resume!.about = editAbout.text!
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
        editName.text = resumeViewController?.userName.text
        editHead.text = resumeViewController?.userHead.text
        editCity.text = resumeViewController?.userCity.text
        editEmail.text = resumeViewController?.userEmail.text
        editAbout.text = resumeViewController?.userAbout.text
        resume = resumeViewController?.resume
        
        
    }

}
