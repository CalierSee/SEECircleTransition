//
//  ViewController.swift
//  SEECircleTransition
//
//  Created by 景彦铭 on 2016/12/16.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animationButtonClick(_ sender: UIButton) {
        let vc: TestViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"TestViewController") as! TestViewController
        present(vc, animated: true, completion: nil)
    }

    
}

