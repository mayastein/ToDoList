//
//  ToDoTableViewController.swift
//  toDoLst
//
//  Created by Maya stein on 7/27/20.
//  Copyright © 2020 KWK. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    //var listOfToDo : [ToDoClass] = []
    var listOfToDo : [ToDoCD] = []
    
    /*
    //code from iterations 0/1
    func createToDo() -> [ToDoClass]{
        let swiftToDo = ToDoClass()
        swiftToDo.description = "Learn Swift"
        swiftToDo.important = true
        
        let dogToDo = ToDoClass()
        dogToDo.description = "walk the dog"
        return [swiftToDo, dogToDo]
        
    }
    */
    
    func getToDos() {
         if let accessToCoreData = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let dataFromCoreData = try? accessToCoreData.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
            listOfToDo = dataFromCoreData
            tableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //listOfToDo = createToDo()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfToDo.count
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let eachToDo = listOfToDo[indexPath.row]
        cell.textLabel?.text = eachToDo.description
        
        if eachToDo.important{
            cell.textLabel?.text = "-!-" + eachToDo.description
        } else {
            cell.textLabel?.text = eachToDo.description
        }
        
        return cell
    }
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

         let eachToDo = listOfToDo[indexPath.row]

         if let thereIsDescription = eachToDo.descriptionInCD {
              if eachToDo.importantInCD {
            cell.textLabel?.text = "-!-" + thereIsDescription
             } else {
            cell.textLabel?.text = eachToDo.descriptionInCD
             }
         }

         return cell
    }
    override func viewWillAppear(_ animated: Bool) {
         getToDos()
    }


    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let nextAddToDoVC = segue.destination as? AddToDoViewController{
            nextAddToDoVC.previousToDoTVC = self
        }
        if let nextCompletedToDoVC = segue.destination as? CompletedToDoViewController {
             //if let choosenToDo = sender as? ToDoClass {
            if let choosenToDo = sender as? ToDoCD{
                  nextCompletedToDoVC.selectedToDo = choosenToDo
                  nextCompletedToDoVC.previousToDoTVC = self
             }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         // this gives us a single ToDo
         let eachToDo = listOfToDo[indexPath.row]

         performSegue(withIdentifier: "moveToCompletedToDoVC", sender: eachToDo)
    }

    

}
