//
//  ViewController.swift
//  GoalList
//
//  Created by Kolten Fluckiger on 7/1/18.
//  Copyright © 2018 Kolten Fluckiger. All rights reserved.
//

import CoreData
import UIKit

// MARK: GoalsViewController

class GoalsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var goalTableView: UITableView!
    // MARK: Variables
    var goals = [Goal]()

    // MARK: Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.delegate = self
        goalTableView.dataSource = self
        goalTableView.register(UINib(nibName: "GoalTableViewCell", bundle: nil), forCellReuseIdentifier: GOAL_TABLEVIEW_CELL)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goalCompleted), name: NSNotification.Name("goalDidComplete"), object: nil)
        
        getGoals()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("goalDidComplete"), object: nil)
    }
    
    // MARK: Functions
    
    @objc func goalCompleted() {
        print("Goal did complete")
    }
    
    func getGoals() {
        let context = appDelegate.persistentContainer.viewContext
        let fetchResult = NSFetchRequest<Goal>(entityName: "Goal")
        let goalRetriever = GoalRetriever(managedContext: context, fetchRequest: fetchResult)
        
        goalRetriever.executeFetch(completion: { [weak self] goal in
            guard let goals = goal else { return }
            self?.goals = goals
        })
    }
    
    // MARK: Outlet Actions
    
    @IBAction func addButton(_: UIButton) {
        performSegue(withIdentifier: ADD_GOAL, sender: self)
    }
}
