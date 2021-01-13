//
//  WorkExpTableViewCell.swift
//  ECA2
//
//  Created by Jaelle Song on 15/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit
// MARK: - Protocol for passing data from cell class to table class
protocol ResumeExpTableViewCellProtocol : class {
    func cellToTableSaveProtocol(_ resume: Resume)
}

class WorkExpTableViewCell: UITableViewCell {
    weak var delegate: ResumeExpTableViewCellProtocol?
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var dates: UILabel!
    @IBAction func deleteExp(_ sender: Any) {
        // send data to delegate
        resume?.workexp.remove(at: indexPathRow!)
        delegate?.cellToTableSaveProtocol(resume!)
    }
    
    @IBAction func editExp(_ sender: Any) {
        delegate?.cellToTableSaveProtocol(resume!)
    }
    var jobExp : Resume.WorkExp?
    var resume : Resume?
    var indexPathRow : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ newResume : Resume? , _ indexPathRow : Int) {
        self.indexPathRow = indexPathRow
        self.resume = newResume
        
        self.jobExp = resume?.workexp[indexPathRow]
        jobTitle.text = jobExp!.title
        company.text = "\(jobExp!.company) - \(jobExp!.city)"
        dates.text = "\(jobExp!.from) - \(jobExp!.to)"
    }
}
