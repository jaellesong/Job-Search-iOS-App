//
//  JobTableViewCell.swift
//  ECA2
//
//  Created by Jaelle Song on 8/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

//import Foundation
import Foundation
import UIKit
//


// MARK: - Protocol for passing data from cell class to table class
protocol JobTableViewCellProtocol : class {
    func cellToTableSaveProtocol(_ job: Job)
}



class JobTableViewCell: UITableViewCell {
    
    // delegate variable create for protocol
    weak var delegate: JobTableViewCellProtocol?
    var job : Job?

    // MARK: - initialize all the elements
    @IBOutlet weak var jobTitle : UILabel?
    @IBOutlet weak var jobCompany : UILabel?
    @IBOutlet weak var jobLocation : UILabel?
    @IBOutlet weak var jobDays : UILabel?
    @IBOutlet weak var jobSalary : UILabel?
    @IBOutlet weak var jobImage : UIImageView?
    @IBOutlet weak var saveBtnDisplay: UIButton!
    @IBOutlet weak var jobWrapper: UIView!
    @IBAction func saveBtn(_ Sender: Any) {
        // bobbing heart animation
        self.saveBtnDisplay.isSelected.toggle()
        UIView.animate(withDuration: 0.1, animations: {
            self.saveBtnDisplay.transform = self.saveBtnDisplay.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
          // Step 2
          UIView.animate(withDuration: 0.1, animations: {
            self.saveBtnDisplay.transform = CGAffineTransform.identity
          })
        })
        self.job?.saved = saveBtnDisplay.isSelected
        self.saveBtnDisplay.tintColor = saveBtnDisplay.isSelected ? UIColor.saveRed : UIColor.textGrey
        // send data to delegate
        delegate?.cellToTableSaveProtocol(job!)
        
    }
    
    // MARK: - initialize cell styles
    func configureCell(_ job:Job) {
        // styling and display options
        self.job = job
        
        self.selectionStyle = .none
        // date formatter
        let dateFor = DateFormatter()
        dateFor.locale = Locale(identifier: "en_US_POSIX")
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date1 = dateFor.date(from: job.date)
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day], from: date1!, to: Date())
        //text display
        self.jobDays?.text = "\(components.day!) days ago"
        self.jobTitle?.text = job.title
        self.jobCompany?.text = job.company
        self.jobLocation?.text = job.location
        self.jobSalary?.text = "$\(job.salary)"
        self.jobImage?.image = UIImage(named: job.company)
        // image styles
        self.jobImage?.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        self.jobImage?.layer.masksToBounds = true
        self.jobImage?.contentMode = .scaleToFill
        self.jobImage?.layer.borderWidth = 1
        self.jobImage?.layer.cornerRadius = 10
        //like button
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        self.saveBtnDisplay.setImage(image, for: .normal)
        self.saveBtnDisplay.setImage(imageFilled, for: .selected)
        self.saveBtnDisplay.isSelected = job.saved
        self.saveBtnDisplay.tintColor = saveBtnDisplay.isSelected ? UIColor.saveRed : UIColor.textGrey
        

    }
    
    
}
