//
//  AddItemTableViewController.swift
//  BuketListApp
//
//  Created by Tarooti on 16/05/1443 AH.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    weak var delegate : saveItem?
    var item:String?
    var indexpp:NSIndexPath?
    @IBOutlet weak var txtInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtInput.text = item

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

   
    @IBAction func Savebtn(_ sender: UIBarButtonItem) {
        let text = txtInput.text!
        delegate?.saveButtonPressed(by: self, with: text, at: indexpp)
    }
    
    @IBAction func Cancelbtn(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
}
