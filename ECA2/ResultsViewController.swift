//
//  ResultsViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 13/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController, JobTableViewCellProtocol {
    var jobs: [Job] = []
    var filteredJobs : [Job] = []
    @IBOutlet weak var mainTableView: UITableView!
    
    static let updateNotification = Notification.Name("updateNotification")
    
    var searchViewController: SearchViewController?
    var filterViewController: FilterViewController?
    var jsTitle: String? = ""
    var jsSalary: String? = ""
    var jsLocation: String? = ""
    var isSearchEmpty: Bool = true
    @IBOutlet weak var searchBar: UITextField!
    @IBAction func searchBarTouch(_ sender: Any) {
        searchBar.isEnabled = false
        performSegue(withIdentifier: "ShowFilterSegue2", sender: nil)
    }
    @IBAction func searchBarEditBegin(_ sender: Any) {
        searchBar.isEnabled = false
        performSegue(withIdentifier: "ShowFilterSegue2", sender: nil)
    }
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        jobs = Job.jobs() //modal
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: ResultsViewController.updateNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        searchBar.isEnabled = true
    }
    
    // when the this comes into view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = mainTableView.indexPathForSelectedRow {
            mainTableView.deselectRow(at: indexPath, animated: true)
        }
        self.navigationController!.isNavigationBarHidden = false
        // search details from searchviewcontroller
        jsTitle = searchViewController?.searchJobTitle.text
        jsSalary = searchViewController?.searchJobSalary.text
        jsLocation = searchViewController?.searchJobLocation.text
        isSearchEmpty = jsTitle!.isEmpty && jsSalary!.isEmpty && jsLocation!.isEmpty ? true : false
        
        reloadFilteredJobs()
        searchBar.text = jsTitle
        searchBar.isEnabled = true
    }
    
    // for incoming data from saved view controller
    @objc func onNotification(notification:Notification) {
        jobs = notification.userInfo!["data"] as! [Job]
        reloadFilteredJobs()
        mainTableView.reloadData()
    }
    
    // send data to jobs detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard
                segue.identifier == "ShowDetailSegue",
                let indexPath = mainTableView.indexPathForSelectedRow,
                let detailViewController = segue.destination as? JobDetailViewController
                else {
                    return
            }
            detailViewController.job = jobs[indexPath.row]
            detailViewController.resultsViewController = self
            detailViewController.indexPath = indexPath // is it nceccsaryy
            
        } else if segue.identifier == "ShowFilterSegue"{
            guard
                segue.identifier == "ShowFilterSegue",
                let filterViewController = segue.destination as? FilterViewController
                else {
                    return
            }
            filterViewController.resultsViewController = self
            
        }else if segue.identifier == "ShowFilterSegue2"{
            guard
                segue.identifier == "ShowFilterSegue2",
                let filterViewController = segue.destination as? FilterViewController
                else {
                    return
            }
            filterViewController.resultsViewController = self
            
        }
        
    }
    
    
    // MARK: - Updating Functions
    // for tapping <3 in the detail page
    func updateSaveData( _ job: Job){
        for (n,njob) in jobs.enumerated() {
            if njob.id == job.id{
                jobs[n] = job
                break
            }
        }
        reloadFilteredJobs()
        mainTableView.reloadData()
        NotificationCenter.default.post(name: SavedViewController.updateNotification, object: nil, userInfo:["data": jobs]) // send updated data to saved vc
    }
    
    // protocol stubs/ delegate method - for tapping <3 on the jobs results page
    func cellToTableSaveProtocol(_ updatingJob: Job) {
        updateSaveData(updatingJob)
    }
    
    // filter function to show the correct data type
    func reloadFilteredJobs() {
        // search fields not empty, then appending to filteredJobs
        if !jsTitle!.isEmpty && !isSearchEmpty {
            filteredJobs = jobs.filter { $0.title.lowercased().contains(jsTitle!.lowercased())
                || $0.company.lowercased().components(separatedBy: " ").contains(jsTitle!.lowercased()) }
        }
        if !jsSalary!.isEmpty && !isSearchEmpty && jsSalary!.isInt {
            filteredJobs = jobs.filter { Int($0.salary)! >= Int(jsSalary!)!
            }
        }
        if !jsLocation!.isEmpty && !isSearchEmpty {
            filteredJobs = jobs.filter { $0.location.lowercased().contains(jsLocation!.lowercased())  }
        }
            
    }
    // additional search view
    // todo: sort data
    
    // search variables from filter view controller
    func updateSearchData(_ filterVC : FilterViewController){
        filterViewController = filterVC
        jsTitle = filterVC.searchJobTitle.text
        jsSalary = filterVC.searchJobSalary.text
        jsLocation = filterVC.searchJobLocation.text
        
        searchBar.text = jsTitle
        isSearchEmpty = jsTitle!.isEmpty && jsSalary!.isEmpty && jsLocation!.isEmpty ? true : false
        // search fields empty, then appending jobs to filteredJobs and force it to true
        if isSearchEmpty {
            filteredJobs = jobs
            isSearchEmpty = false
        }
        reloadFilteredJobs()
        // sorting data
        switch filterVC.sortedBy! {
        case .recent:
            filteredJobs = filteredJobs.sorted { $0.date < $1.date }
        case .salaryHighest:
            filteredJobs = filteredJobs.sorted { $0.salary > $1.salary }
        case .salaryLowest:
            filteredJobs = filteredJobs.sorted { $0.salary < $1.salary }
        case .nearby:
            filteredJobs = filteredJobs.sorted { $0.location < $1.location }
        }
        
        mainTableView.reloadData()
        
    }
    
    
    // MARK: - Table Methods
    override func tableView(_ mainTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !isSearchEmpty ? filteredJobs.count : jobs.count
    }
    
    override func tableView(_ mainTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JobTableViewCell
        let job = !isSearchEmpty ? filteredJobs[indexPath.row] : jobs[indexPath.row]
        cell.configureCell(job)
        cell.delegate = self
        return cell
    }
    
    //    // tester to see if array is updated
    //    override func tableView(_ mainTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let job = jobs[indexPath.row]
    //        print("Row at \(indexPath.row) is \(job.saved)")
    //    }
    
}
