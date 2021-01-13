//
//  SavedViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 13/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JobTableViewCellProtocol{
    
    static let updateNotification = Notification.Name("updateNotification")
    var jobs: [Job] = []
    var showingJobs : [Job] = []
    
    @IBOutlet weak var savedTableView: UITableView!
    
    @IBOutlet weak var segmentedDisplay: UISegmentedControl!
    @IBAction func segmentSavedApplied(_ sender: Any) {
        reloadShowingJobs()
        savedTableView.reloadData()
    }
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        jobs = Job.jobs() //modal
        savedTableView.dataSource = self
        savedTableView.delegate = self
        reloadShowingJobs() // initialize job display data
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: SavedViewController.updateNotification, object: nil)
        
    }
    
    // when the this comes into view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = savedTableView.indexPathForSelectedRow {
            savedTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // for incoming data from results view controller
    @objc func onNotification(notification:Notification) {
        jobs = notification.userInfo!["data"] as! [Job]
        reloadShowingJobs() // refresh the showing data
        savedTableView.reloadData()
    }
    
    // send data to jobs detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showSavedDetailSegue",
            let indexPath = savedTableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? JobDetailViewController
            else {
                return
        }
        
        detailViewController.job = showingJobs[indexPath.row]
        detailViewController.savedViewController = self
        detailViewController.indexPath = indexPath // check if is neccessary
        
    }
    
    
    // MARK: - Updating Functions
    // for tapping <3 in the detail page - relies on job id
    func updateSaveData(_ job: Job){
        for (n,njob) in jobs.enumerated() {
            if njob.id == job.id{
                jobs[n] = job
                break
            }
        }
        reloadShowingJobs()
        savedTableView.reloadData()
        NotificationCenter.default.post(name: ResultsViewController.updateNotification, object: nil, userInfo:["data": jobs]) // send updated data to results vc
    }
    // protocol stubs/ delegate method - for tapping <3 on the saved jobs page
    func cellToTableSaveProtocol(_ updatingJob: Job) {
        updateSaveData(updatingJob)
    }
    
    // filter function to show the correct data type
    func reloadShowingJobs() {
        switch segmentedDisplay.selectedSegmentIndex {
        case 0: // show saved data
            showingJobs = jobs.filter({ $0.saved })
        case 1: //show applied data
            showingJobs = jobs.filter({ $0.applied })
        default:
            showingJobs = []
        }
    }
    
    
    // MARK: - Table Methods
    func tableView(_ savedTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showingJobs.count
    }
    
    func tableView(_ savedTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! JobTableViewCell
        let job = showingJobs[indexPath.row]
        cell.configureCell(job)
        cell.delegate = self
        return cell
    }
    
    
    
}
