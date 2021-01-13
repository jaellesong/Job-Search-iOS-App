//
//  JobTableViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 8/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit
//UITableViewController
// MasterViewController
class JobTableViewController: UIViewController, UITableViewDelegate, JobTableViewCellProtocol {
    
    @IBOutlet weak var mainTableView: UITableView!
//    @IBOutlet var searchFooter: SearchFooter!
//    @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
    
    
    var jobs: [Job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobs = Job.jobs() //modal
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
    

}

extension JobTableViewController: UITableViewDataSource {
    func tableView(_ mainTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return jobs.count
    }

    func tableView(_ mainTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = mainTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JobTableViewCell
      let job = jobs[indexPath.row]
      cell.configureCell(job)
      cell.delegate = self
      
      return cell
    }

    // tester to see if array is updated
    override func tableView(_ mainTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let job = jobs[indexPath.row]
      print("Row at \(indexPath.row) is \(job.saved)")
    }

    // MARK: - Delegagte Methods
    // protocol stubs/ delegate method
    func jobSaved(_ sender: JobTableViewCell, isSaved: Bool) {
      guard let tappedIndexPath = mainTableView.indexPath(for: sender) else {
          return
      }
      let cell = mainTableView.cellForRow(at: tappedIndexPath) as! JobTableViewCell
      
      jobs[tappedIndexPath.row] = cell.job!
    //        print("jobsavedelegatecalled")
    }
}
