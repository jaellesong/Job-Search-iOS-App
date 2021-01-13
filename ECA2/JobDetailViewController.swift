//
//  JobDetailViewController.swift
//  ECA2
//
//  Created by Jaelle Song on 12/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class JobDetailViewController: UIViewController {
    
    var resultsViewController : ResultsViewController?
    var savedViewController : SavedViewController?
    
    var job: Job? {
      didSet {
        configureView()
      }
    }
    var indexPath: IndexPath?
    @IBOutlet weak var detailJobLocation: UILabel!
    @IBOutlet weak var detailJobSalary: UILabel!
    @IBOutlet weak var detailJobDays: UILabel!
    @IBOutlet weak var detailJobCompany: UILabel!
    @IBOutlet weak var detailJobTitle: UILabel!
    @IBOutlet weak var detailJobImage: UIImageView!
    @IBOutlet weak var detailJobSaveBtnDisplay: UIButton!
    
    @IBAction func detailJobSaveBtn(_ sender: Any) {
        // bobbing heart animation
        self.detailJobSaveBtnDisplay.isSelected.toggle()
        UIView.animate(withDuration: 0.1, animations: {
            self.detailJobSaveBtnDisplay.transform = self.detailJobSaveBtnDisplay.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
          // Step 2
          UIView.animate(withDuration: 0.1, animations: {
            self.detailJobSaveBtnDisplay.transform = CGAffineTransform.identity
          })
        })
        self.job?.saved = detailJobSaveBtnDisplay.isSelected
        self.detailJobSaveBtnDisplay.tintColor = detailJobSaveBtnDisplay.isSelected ? UIColor.saveRed : UIColor.textGrey
        resultsViewController?.updateSaveData(job!)
        savedViewController?.updateSaveData(job!)
        
    }
    @IBOutlet weak var detailJobDescription: UILabel!
    // initialize job object
    @IBOutlet weak var detailScrollView: UIScrollView!

    @IBOutlet weak var detailJobApplyBtnDisplay: UIButton!
    @IBAction func detailJobApplyBtn(_ sender: Any) {
        // just pop out alert ok or not
        let alert = UIAlertController(title: "Do you want to send your resume for this job position?", message: "You can only apply once", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { action in
            self.job!.applied = true
            self.detailJobApplyBtnDisplay.isEnabled = false
            self.detailJobApplyBtnDisplay?.alpha = 0.5
            self.resultsViewController?.updateSaveData(self.job!)
            self.savedViewController?.updateSaveData(self.job!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        //
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // intialize job object
        configureView()
        // manually set bottom anchor
        detailScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: detailJobDescription.bottomAnchor).isActive = true
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

    }


    
    func configureView() {
        if let job = job{
            // date formatter
            let dateFor = DateFormatter()
            dateFor.locale = Locale(identifier: "en_US_POSIX")
            dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date1 = dateFor.date(from: job.date)
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.day], from: date1!, to: Date())
            //text display
            self.detailJobDays?.text = "\(components.day!) days ago"
            self.detailJobTitle?.text = job.title
            self.detailJobCompany?.text = job.company
            self.detailJobLocation?.text = job.location
            self.detailJobSalary?.text = "$\(job.salary)"
            self.detailJobImage?.image = UIImage(named: job.company)
            // image styles
            self.detailJobImage?.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
            self.detailJobImage?.layer.masksToBounds = true
            self.detailJobImage?.contentMode = .scaleToFill
            self.detailJobImage?.layer.borderWidth = 1
            self.detailJobImage?.layer.cornerRadius = 10
            //like button
            let image = UIImage(systemName: "heart")
            let imageFilled = UIImage(systemName: "heart.fill")
            self.detailJobSaveBtnDisplay?.setImage(image, for: .normal)
            self.detailJobSaveBtnDisplay?.setImage(imageFilled, for: .selected)
            self.detailJobSaveBtnDisplay?.isSelected = job.saved
            self.detailJobSaveBtnDisplay?.tintColor = detailJobSaveBtnDisplay.isSelected ? UIColor.saveRed : UIColor.textGrey
            // apply for job button

            detailJobApplyBtnDisplay?.styleFindBtn()
            detailJobApplyBtnDisplay?.setTitle("Job Applied", for: .disabled)
            if job.applied {
                detailJobApplyBtnDisplay?.isEnabled = false 
                detailJobApplyBtnDisplay?.alpha = 0.5
            }
            detailJobDescription?.text = job.description
            
            
        }
    }
    
}
