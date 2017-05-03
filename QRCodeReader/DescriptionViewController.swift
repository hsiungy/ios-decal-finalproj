//
//  DescriptionViewController.swift
//  QRCodeReader
//
//  Created by Placeholder on 5/2/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    var chosenImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(QRViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var descrip: UITextField!
    @IBAction func saveDescrip(_ sender: UIButton) {
        performSegue(withIdentifier: "DescripToList", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.navigationBar.isHidden = false
        //navigationController?.navigationItem.setHidesBackButton(true, animated:true);
        let destination = segue.destination as! CategoryViewController
        destination.navigationItem.setHidesBackButton(true, animated: true)
        if (CategoryViewController.myData.itemArray == nil) {
            CategoryViewController.myData.itemArray = []
        }
        CategoryViewController.myData.itemArray?.append(Item(name: descrip.text!, img: chosenImage!))
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
