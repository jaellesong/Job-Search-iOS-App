//
//  SearchViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 14/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchJobNavItem: UINavigationItem!
    @IBOutlet weak var searchJobWrapper: UIView!
    @IBOutlet weak var searchJobTitle: UITextField!
    @IBOutlet weak var searchJobSalary: UITextField!
    @IBOutlet weak var searchJobLocation: UITextField!
    @IBOutlet weak var searchJobBtnDisplay: UIButton!
    @IBAction func searchJobBtn(_ sender: Any) {
        // pass data to next segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = true
    }
    
    // send data to jobs detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowResultsSegue",
            let resultsViewController = segue.destination as? ResultsViewController
            else {
                return
        }
        resultsViewController.searchViewController = self
        
    }
    // MARK: - functions
    
    func configureStyle() {
        // text fields
        searchJobTitle.useUnderline()
        searchJobSalary.useUnderline()
        searchJobLocation.useUnderline()
        // job button
        searchJobBtnDisplay.styleFindBtn()
        // text wrapper
        searchJobWrapper?.layer.shadowColor = UIColor.black.cgColor
        searchJobWrapper?.layer.shadowOpacity = 0.1
        searchJobWrapper?.layer.shadowOffset = .zero
        searchJobWrapper?.layer.shadowRadius = 10
        
    }
    

}


