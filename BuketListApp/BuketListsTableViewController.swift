//
//  BuketListsTableViewController.swift
//  BuketListApp
//
//  Created by Tarooti on 16/05/1443 AH.
//

import UIKit
import CoreData

class BuketListsTableViewController: UITableViewController, saveItem {

    var items:[Buket] = []
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        fetchAllItems()
    }
    
    func fetchAllItems(){
        let itemReqest = NSFetchRequest<NSFetchRequestResult>(entityName: "Buket")
        
        do{
            let results = try managedObjectContext.fetch(itemReqest)
            items = results as! [Buket]
        }catch{
            print(error.localizedDescription)
        }
    }
    func saveContext(){
        do{
            try managedObjectContext.save()
        }catch {
            print(error)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditSegue", sender: indexPath)

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        saveContext()
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddSegue" {
            let navigationControll = segue.destination as! UINavigationController
            let addItemTableController = navigationControll.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
        }else if segue.identifier == "EditSegue"{
            let navigationControll = segue.destination as! UINavigationController
            let addItemTableController = navigationControll.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self
            let indexpath = sender as! NSIndexPath
            let item = items[indexpath.row]
            addItemTableController.indexpp = indexpath
            addItemTableController.item = item.text
        
            
        }

    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    func saveButtonPressed(by controller: AddItemTableViewController,with text:String , at indexpath : NSIndexPath?){
        if let al = indexpath {
            items[al.row].text = text
            saveContext()
            
        }else{
            if text == "" {
                print("You Should Enter Something!")
            }else{
                
                let newItemEntity = Buket(context: managedObjectContext)
                newItemEntity.text = text
                saveContext()
                
                items.append(newItemEntity)
            }

        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)



    }


}
