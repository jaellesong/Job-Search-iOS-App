//
//  ResumeViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 15/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//
import UIKit

class ResumeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ResumeExpTableViewCellProtocol {
    var resume: Resume!
    var workExp: [Resume.WorkExp] = []
    @IBOutlet weak var contentWrap: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var workExpTableView: UITableView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHead: UILabel!
    
    @IBOutlet weak var userCity: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var userDp: UIView!
    @IBOutlet weak var userInitials: UILabel!
    @IBOutlet weak var userAbout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resume = Resume.resume()[0]
        workExp = resume.workexp
        // manually set bottom anchor
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentWrap.bottomAnchor).isActive = true
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        workExpTableView.dataSource = self
        workExpTableView.delegate = self
        loadData()
    }
    
    // send data to jobs detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditNameSegue" {
            guard
                segue.identifier == "EditNameSegue",
                let editNameViewController = segue.destination as? EditNameViewController
                else {
                    return
            }
            editNameViewController.resumeViewController = self
        }
        else if segue.identifier == "EditJobSegue"{
            guard
                segue.identifier == "EditJobSegue",
                
                let indexPath = workExpTableView.indexPathForSelectedRow,
                let editJobViewController = segue.destination as? EditJobViewController
                else {
                    return
            }
            editJobViewController.resumeViewController = self
            editJobViewController.indexPath = indexPath.row

        }
        
    }
    // MARK: - Updating Functions
    
    func loadData (){
        userName.text = resume.name
        userInitials.text = resume.name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        userHead.text = resume.headline
        userCity.text = resume.city
        userEmail.text = resume.email
        userAbout.text = resume.about

        userDp.layer.masksToBounds = true
        userDp.contentMode = .scaleToFill
        userDp.layer.borderWidth = 2
        userDp.layer.cornerRadius = 95/2
        userDp.layer.borderColor = UIColor.myBlue.cgColor
        userDp.backgroundColor = .clear
    }
    // for tapping <3 in the detail page
    func updateSaveData(_ newResume: Resume){
        resume = newResume
        workExp = resume.workexp
        workExpTableView.reloadData()
    }
    
    // protocol stubs/ delegate method - for tapping <3 on the jobs results page
    func cellToTableSaveProtocol(_ resume: Resume) {
        updateSaveData(resume)
    }
    func updateUserData(_ newResume: Resume){
        resume = newResume
        workExp = resume.workexp
        loadData()
        workExpTableView.reloadData()
    }
   // MARK: - Table Methods
func tableView(_ workExpTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workExp.count
    }

    func tableView(_ workExpTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workExpTableView.dequeueReusableCell(withIdentifier: "ExpCell", for: indexPath) as! WorkExpTableViewCell
        cell.configureCell(resume, indexPath.row)
        cell.delegate = self
        return cell
    }
    

}
