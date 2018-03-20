//
//  ViewController.swift
//  closure
//
//  Created by Andrew Foster on 5/29/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var activitySpiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpiner.isHidden = true
    }

    @IBAction func getTempTapped(_ sender: Any) {
        
        activitySpinerAnimation(hidden: false)
        
        let helper = APIHelper()
        helper.getTemp { (temp, success) in
            if success {
                
                DispatchQueue.main.async {
                    self.tempLbl.text = temp
                    self.activitySpinerAnimation(hidden: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.tempLbl.text = "No Data!"
                }
            }
        }
        
    }
    
    func activitySpinerAnimation(hidden: Bool) {
        activitySpiner.isHidden = hidden
        
        if hidden {
            activitySpiner.stopAnimating()
        } else {
            activitySpiner.startAnimating()
        }
    }

}

