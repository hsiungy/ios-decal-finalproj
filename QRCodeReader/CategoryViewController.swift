//
//  CategoryViewController.swift
//  QRCodeReader
//
//  Created by Placeholder on 5/1/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ItemView: UITableView!
    
    struct myData {
        static var itemArray: [Item]?
    }
    
    //var itemArray: [Item]?
    var selectedIndexPath: IndexPath?
    var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemView.delegate = self
        ItemView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (myData.itemArray == nil) {
            return 0
        }
        return (myData.itemArray?.count)!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //item = itemArray![indexPath.item]
        let cell = ItemView.dequeueReusableCell(withIdentifier: "reuseTableCell", for: indexPath) as? ItemTableViewCell
        if (myData.itemArray == nil) {
            return cell!
        }
        cell?.itemImg.image = myData.itemArray?[indexPath.row].img
        cell?.itemName.text = myData.itemArray![indexPath.row].name
        return cell!
    }
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "itemToCamera", sender: self)
    }
    @IBAction func qrCodeGen(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "profileToQR", sender: self)
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
