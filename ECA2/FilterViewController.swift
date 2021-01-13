//
//  FilterViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 15/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    var resultsViewController : ResultsViewController?
    var sortedBy : sortBy? = .recent
    enum sortBy {
        case recent
        case salaryHighest
        case salaryLowest
        case nearby

        var rawValue: String {
          switch self {
          case .recent: return "recent"
          case .salaryHighest: return "salaryHighest"
          case .salaryLowest: return "salaryLowest"
          case .nearby: return "nearby"
          }
        }
    }
    
    @IBOutlet weak var sortRecentDis: UIButton!
    @IBOutlet weak var sortHighLowDis: UIButton!
    @IBOutlet weak var sortLowHighDis: UIButton!
    @IBOutlet weak var sortNearbyDis: UIButton!
    
    @IBOutlet weak var searchJobTitle: UITextField!
    @IBOutlet weak var searchJobSalary: UITextField!
    @IBOutlet weak var searchJobLocation: UITextField!
    
    @IBOutlet weak var searchJobBtnDis: UIButton!
    @IBAction func searchJobDis(_ sender: Any) {
        resultsViewController?.updateSearchData(self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sortRecent(_ sender: Any) {
        sortedBy = .recent
        selectSortBtn()
        
    }
    @IBAction func sortHighLow(_ sender: Any) {
        sortedBy = .salaryHighest
        selectSortBtn()
    }
    @IBAction func sortLowHigh(_ sender: Any) {
        sortedBy = .salaryLowest
        selectSortBtn()
    }
    @IBAction func sortNearby(_ sender: Any) {
        sortedBy = .nearby
        selectSortBtn()
    }
    
    @IBAction func resetBtn(_ sender: Any) {
        searchJobTitle.text = ""
        searchJobSalary.text = ""
        searchJobLocation.text = ""
        sortedBy = .recent
        selectSortBtn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func selectSortBtn(){
        // dismiss all buttons
        sortRecentDis.isNegative()
        sortHighLowDis.isNegative()
        sortLowHighDis.isNegative()
        sortNearbyDis.isNegative()
        // check which is selected
        switch sortedBy{
        case .recent:
            sortRecentDis.isPositive()
        case .salaryHighest:
            sortHighLowDis.isPositive()
        case .salaryLowest:
            sortLowHighDis.isPositive()
        case .nearby:
            sortNearbyDis.isPositive()
        case .none:
            sortRecentDis.isPositive()
            sortedBy = .recent
        }
        
    }
    


    func configure(){
        // set the buttons styles
        sortRecentDis.styleSortBtn()
        sortHighLowDis.styleSortBtn()
        sortLowHighDis.styleSortBtn()
        sortNearbyDis.styleSortBtn()
        // text fields styles
        searchJobTitle.useUnderline()
        searchJobSalary.useUnderline()
        searchJobLocation.useUnderline()
        // job button
        searchJobBtnDis?.styleFindBtn()
        // set text field text
        let initalSearch = resultsViewController!.searchViewController!
        searchJobTitle.text = initalSearch.searchJobTitle.text!
        searchJobSalary.text = initalSearch.searchJobSalary.text!
        searchJobLocation.text = initalSearch.searchJobLocation.text!
        let previousFVC : FilterViewController? = resultsViewController?.filterViewController ?? nil
        if previousFVC != nil{
            sortedBy = previousFVC!.sortedBy
            selectSortBtn()
        }
        
    }
    
    func setSortBtn(_ button:UIButton!){
        button.tintColor = .clear
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGrey.cgColor
        button.setTitleColor(.myBlue, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = button.isSelected ? .myBlue : .white
    }

}

// pass back data to rvc

