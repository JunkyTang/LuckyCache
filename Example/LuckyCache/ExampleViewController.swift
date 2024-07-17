//
//  ExampleViewController.swift
//  LuckyCache_Example
//
//  Created by junky on 2024/7/17.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LuckyCache

class ExampleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        
    }

    var list = ["Save", "Save in memory", "Save in disk", "Save Condition", "Remove", "Remove from memory", "Remove from disk", "Get", "Get from memory", "Get from disk", "Remove all", "Remove all memory", "Remove all disk", "AUTO"]

    let cache: LuckyCache = LuckyCache()
    
    let image: UIImage = UIImage(named: "test")!
    
    let key = "image"
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let action = list[indexPath.row]
        let start = Date().timeIntervalSince1970
        handlerException {
            if action == "Save" {
                try self.cache.set(obj: image, key: key)
            }else if action == "Save in memory" {
                try self.cache.set(obj: image, key: key, option: [.memory])
            }else if action == "Save in disk" {
                try self.cache.set(obj: image, key: key, option: [.disk])
            }else if action == "Save Condition" {
                try self.cache.set(obj: image, key: key, validity: .duration(startDate: Date(), duration: 10))
            }else if action == "Remove" {
                self.cache.remove(key: key)
            }else if action == "Remove from memory" {
                self.cache.remove(key: key, option: [.memory])
            }else if action == "Remove from disk" {
                self.cache.remove(key: key, option: [.disk])
            }else if action == "Get" {
                let obj: UIImage = try self.cache.get(for: key)
                print(obj)
            }else if action == "Get from memory" {
                let obj: UIImage = try self.cache.get(for: key, option: [.memory])
                print(obj)
            }else if action == "Get from disk" {
                let obj: UIImage = try self.cache.get(for: key, option: [.disk])
                print(obj)
            }else if action == "Remove all" {
                self.cache.removeAll()
            }else if action == "Remove all memory" {
                self.cache.removeAll(option: [.memory])
            }else if action == "Remove all disk" {
                self.cache.removeAll(option: [.disk])
            }else if action == "AUTO" {
                
                
                self.cache.remove(key: key)
                var obj: UIImage? = try? self.cache.get(for: key, option: [.memory])
                var obj1: UIImage? = try? self.cache.get(for: key, option: [.disk])
                assert((obj == nil && obj1 == nil), "Remove cache failure")
                
                
                self.cache.remove(key: key)
                try? self.cache.set(obj: image, key: key)
                obj = try? self.cache.get(for: key, option: [.memory])
                obj1 = try? self.cache.get(for: key, option: [.disk])
                assert((obj != nil && obj1 != nil), "Save cache failure")
                
                self.cache.remove(key: key)
                try? self.cache.set(obj: image, key: key, option: [.memory])
                obj = try? self.cache.get(for: key, option: [.memory])
                obj1 = try? self.cache.get(for: key, option: [.disk])
                assert((obj != nil && obj1 == nil) , "Save to memory failure")
                
                
                self.cache.remove(key: key)
                try? self.cache.set(obj: image, key: key, option: [.disk])
                obj = try? self.cache.get(for: key, option: [.memory])
                obj1 = try? self.cache.get(for: key, option: [.disk])
                assert((obj == nil && obj1 != nil) , "Save to disk failure")
                
            }
        }
        let end = Date().timeIntervalSince1970

        print("time: \(end - start)")
    }
    
    
    func handlerException(throwable: () throws -> Void) {
        
        do {
            try throwable()
        } catch {
            print(error)
        }
        
    }
    
    
    
}
